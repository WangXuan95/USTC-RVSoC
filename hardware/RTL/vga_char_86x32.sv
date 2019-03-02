module vga_char_86x32 #(
    parameter VGA_CLK_DIV = 1
)(
    // clock
	input  logic clk, rst_n,
    // vga interfaces
	output logic hsync, vsync,
	output logic red, green, blue,
    // user interface
    output logic req,
    output logic [11:0] addr,
    input  logic [ 7:0] ascii
);
localparam  H_END           =                 10'd688,
            H_BRSTART       = H_END         + 10'd4  ,
            H_BREND         = H_BRSTART     + 10'd30 ,
            H_SYNCSTART     = H_BREND       + 10'd25 ,
            H_SYNCEND       = H_SYNCSTART   + 10'd128,
            H_BLSTART       = H_SYNCEND     + 10'd89 ,
            H_BLEND         = H_BLSTART     + 10'd30 ,
            H_PERIOD        = H_BLEND       + 10'd4  ,
            V_END           =                 10'd512,
            V_BRSTART       = V_END         + 10'd4  ,
            V_BREND         = V_BRSTART     + 10'd30 ,
            V_SYNCSTART     = V_BREND       + 10'd38 ,
            V_SYNCEND       = V_SYNCSTART   + 10'd4  ,
            V_BLSTART       = V_SYNCEND     + 10'd66 ,
            V_BLEND         = V_BLSTART     + 10'd30 ,
            V_PERIOD        = V_BLEND       + 10'd4  ;

logic [3:0] rlp=4'h0, clp=4'h0, hsp=4'h0, vsp=4'h0;
logic vlbr=1'b0, vgbl=1'b0, vlbl=1'b0, vgbr=1'b0, hlbr=1'b0, hgbl=1'b0, hlbl=1'b0, hgbr=1'b0;
logic vir=1'b0, hir=1'b0, vbr=1'b0, hbr=1'b0, vbl=1'b0, hbl=1'b0, hb=1'b0, vb=1'b0, border=1'b0;
logic [9:0] cnt = 0, hcnt = 0, vcnt = 0;
logic req1 = 1'b0, req2 = 1'b0;
logic [7:0] ascii_bufferout, ascii_latch=8'h0, ascii_to_rom;
logic [7:0] rom_data;
logic [6:0] x_h, x_h1=7'h0, x_h2=7'h0;
logic [5:0] y_h;

logic [2:0] x_l, x_l1 = 3'h0, x_l2 = 3'h0, x_l3 = 3'h0, x_l4 = 3'h0;
logic [3:0] y_l, y_l1 = 4'h0, y_l2 = 4'h0, y_l3 = 4'h0;

assign {x_h, x_l} = hcnt;
assign {y_h, y_l} = vcnt;

initial begin hsync=1'b0; vsync=1'b0; {red,green,blue}=3'h0; req=1'b0; addr = 12'h0; end

always @ (posedge clk)
    if(~rst_n) begin
        vlbr<= 1'b0;
        vgbl<= 1'b0;
        vlbl<= 1'b0;
        vgbr<= 1'b0;
        hlbr<= 1'b0;
        hgbl<= 1'b0;
        hlbl<= 1'b0;
        hgbr<= 1'b0;
        vir <= 1'b0;
        hir <= 1'b0;
        vbr <= 1'b0;
        hbr <= 1'b0;
        vbl <= 1'b0;
        hbl <= 1'b0;
        hb  <= 1'b0;
        vb  <= 1'b0;
        border <= 1'b0;
    end else begin
        vlbr<= vcnt <  V_BREND  ;
        vgbl<= vcnt >= V_BLSTART;
        vlbl<= vcnt <  V_BLEND  ;
        vgbr<= vcnt >= V_BRSTART;
        hlbr<= hcnt <  H_BREND  ;
        hgbl<= hcnt >= H_BLSTART;
        hlbl<= hcnt <  H_BLEND;
        hgbr<= hcnt >= H_BRSTART;
        vir <= vlbr | vgbl;
        hir <= hlbr | hgbl;
        vbr <= vgbr & vlbr;
        hbr <= hgbr & hlbr;
        vbl <= vgbl & vlbl;
        hbl <= hgbl & hlbl;
        hb  <= (hbr | hbl) & vir;
        vb  <= (vbr | vbl) & hir;
        border <= hb | vb;
    end

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        cnt  <= 10'h0;
        hcnt <= 10'h0;
        vcnt <= 10'h0;
    end else begin
        cnt <= (cnt<(VGA_CLK_DIV-1)) ? cnt + 10'h1 : 10'h0;
        if(cnt==10'h0) begin
            if(hcnt < H_PERIOD) begin
                hcnt <= hcnt + 10'h1;
            end else begin
                hcnt <= 10'h0;
                vcnt <= (vcnt<V_PERIOD) ? vcnt + 10'h1 : 10'h0;
            end
        end
    end
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        req <= 1'b0;
        req1<= 1'b0;
        req2<= 1'b0;
    end else begin
        req <= cnt==10'h0 && hcnt<H_END && vcnt<V_END && x_l==3'h0 && y_l==4'h0;
        req1<= req;
        req2<= req1;
    end
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        clp <= 4'h0;
        rlp <= 4'h0;
        hsp <= 4'h0;
        vsp <= 4'h0;
    end else begin
        clp <= {clp[2:0], ( cnt==10'h0 ) };
        rlp <= {rlp[2:0], ( hcnt<H_END && vcnt<V_END ) };
        hsp <= {hsp[2:0], ( hcnt>=H_SYNCSTART && hcnt<H_SYNCEND ) };
        vsp <= {vsp[2:0], ( vcnt>=V_SYNCSTART && vcnt<V_SYNCEND ) };
    end

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        addr <= 12'h0;
    end else begin
        if( cnt==10'h0 && hcnt<H_END && vcnt<V_END ) begin
            addr <= {y_h[4:0],x_h};
        end else begin
            addr <= 12'h0;
        end
    end
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        {x_l1, y_l1, x_l2, y_l2, x_l3, y_l3, x_l4, x_h1, x_h2} <= 38'h0;
    else
        {x_l1, y_l1, x_l2, y_l2, x_l3, y_l3, x_l4, x_h1, x_h2} <= {x_l, y_l, x_l1, y_l1, x_l2, y_l2, x_l3, x_h, x_h1};

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        hsync <= 1'b0;
        vsync <= 1'b0;
        {red,green,blue} <= 3'h0;
    end else begin
        if(clp[3]) begin
            hsync <= ~hsp[3];
            vsync <= ~vsp[3];
            if(rlp[3])
                {red,green,blue} <= {3{rom_data[x_l4]}};
            else if(border)
                {red,green,blue} <= 3'b100;
            else
                {red,green,blue} <= 3'b000;
        end
    end
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        ascii_latch <= 8'h0;
    else begin
        ascii_latch <= req1 ? ascii : 8'h0;
    end

// buffered a line, 86 chars, The goal is to minimize the number of memory accesses
ram128B ram128B_vga_line_buffer_inst(            // 128B
    .clk        (  clk             ),
    .i_we       (  req1            ),
    .i_addr     (  x_h2            ),
    .i_wdata    (  ascii           ),
    .o_rdata    (  ascii_bufferout )
);

assign ascii_to_rom = req2 ? ascii_latch : ascii_bufferout;
    
char8x16_rom char_8x16_rom_inst(
    .clk        ( clk                  ),
    .addr       ( {ascii_to_rom, y_l3} ),
    .data       ( rom_data             )
);

endmodule
