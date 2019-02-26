module video_ram(
    input  logic clk, rst_n,
	output logic o_hsync, o_vsync,
	output logic [15:0] o_pixel,
    naive_bus.slave  bus
);

logic [ 9:0] vga_addr_h;
logic [ 1:0] vga_addr_l, vga_addr_l_latch = 2'b00;
logic [ 7:0] vga_ascii;
logic [ 9:0] cell_wr_addr;
logic [ 7:0] vga_rdata [4];

assign cell_wr_addr = bus.wr_addr[11:2];

assign bus.rd_gnt = bus.rd_req;
assign bus.wr_gnt = bus.wr_req;
assign bus.rd_data = 0;

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        vga_addr_l_latch <= 2'b00;
    else
        vga_addr_l_latch <= vga_addr_l;
    
ram ram_block_inst_0(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[0] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[ 7: 0]        ),
    .i_raddr   ( vga_addr_h                ),
    .o_rdata   ( vga_rdata[0]              )
);
ram ram_block_inst_1(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[1] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[15: 8]        ),
    .i_raddr   ( vga_addr_h                ),
    .o_rdata   ( vga_rdata[1]              )
);
ram ram_block_inst_2(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[2] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[23:16]        ),
    .i_raddr   ( vga_addr_h                ),
    .o_rdata   ( vga_rdata[2]              )
);
ram ram_block_inst_3(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[3] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[31:24]        ),
    .i_raddr   ( vga_addr_h                ),
    .o_rdata   ( vga_rdata[3]              )
);

always_comb
    case(vga_addr_l_latch)
    2'b00 : vga_ascii <= vga_rdata[0];
    2'b01 : vga_ascii <= vga_rdata[1];
    2'b10 : vga_ascii <= vga_rdata[2];
    2'b11 : vga_ascii <= vga_rdata[3];
    endcase

vgaChar98x36 vga_char_inst(
    .clk       ( clk                     ),
    .rst_n     ( rst_n                   ),
    .hsync     ( o_hsync                 ),
    .vsync     ( o_vsync                 ),
    .pixel     ( o_pixel                 ),
    .addr      ( {vga_addr_h,vga_addr_l} ),
    .ascii     ( vga_ascii               )
);

endmodule




module vgaChar98x36(
    // clock
	input  clk, rst_n,
    // vga interfaces
	output hsync, vsync,
	output [15:0] pixel,
    // user interface
    output [11:0] addr,
    input  [7:0] ascii
);
wire b;
wire [15:0] req_pixel;
reg  [15:0] border, border_latch;
wire req;
wire [2:0] x_l;
wire [3:0] y_l;
wire [6:0] x_h;
wire [5:0] y_h;
wire [9:0] x, y;
reg  [9:0] x_latch, y_latch;

always @ (posedge clk) begin
    x_latch <= x;
    y_latch <= y;
    border_latch <= border;
end

assign {x_h, x_l} = x - 10'd8;
assign {y_h, y_l} = y - 10'd12;

assign addr = y_h * 12'd98 + x_h;

vga vga_inst(
    .clk       (clk),
    .hsync     (hsync),
    .vsync     (vsync),
    .pixel     (pixel),
    .req       (req),
    .x         (x),
    .y         (y),
    .req_pixel (req_pixel)
);

assign req_pixel = ( x_latch>=8 && x_latch<(800-8) && y_latch>=12 && y_latch<(600-12) ) ? {16{b}} : border_latch;

always @ (posedge clk)
    if(req)
        border <= ( x<5 || x>(800-5) || y<5 || y>(600-5) ) ? 16'hff00 : 16'h0000;

char8x16_rom char_8x16_rom_inst(
    .clk        ( clk    ),
    .rst_n      ( rst_n  ),
    .ascii      ( ascii  ),
    .x          ( x_l    ),
    .y          ( y_l    ),
    .b          ( b      )
);

endmodule






module vga(
    // clock
	input  clk,
    // vga interface
	output reg hsync, vsync,
	output reg [15:0]  pixel,
    // user interface
    output req,
    output [ 9:0] x, y,
    input  [15:0] req_pixel
);
localparam  H_END           = 800,
            H_SYNCSTART     = H_END + 8,
            H_SYNCEND       = H_SYNCSTART + 128,
            H_PERIOD        = H_SYNCEND + 72,
			
            V_END           = 600,
            V_SYNCSTART     = V_END + 8,
            V_SYNCEND       = V_SYNCSTART + 4,
            V_PERIOD        = V_SYNCEND + 36;

reg [31:0] hcnt,vcnt;

always @ (posedge clk)
    hcnt <= (hcnt<H_PERIOD) ? hcnt + 1 : 0;

always @ (posedge clk)
	hsync <= ~(hcnt>=H_SYNCSTART && hcnt<H_SYNCEND);

always @ (posedge hsync)
    vcnt <= (vcnt<V_PERIOD) ? vcnt + 1 : 0;

always @ (posedge hsync)
    vsync <= ~(vcnt>=V_SYNCSTART && vcnt<V_SYNCEND);

wire h_range = hcnt<H_END;
wire v_range = vcnt<V_END;
wire range   = (h_range & v_range);

assign x = range ? hcnt[9:0] : 10'h0;
assign y = range ? vcnt[9:0] : 10'h0;

assign req = range;

always @ (posedge clk)
    pixel <= (hcnt>0 && hcnt<=H_END && v_range) ? req_pixel : 16'h0;

endmodule





// 存放所有ASCII字符的字码
// 该ROM自动综合成Block RAM
module char8x16_rom(
    input  clk, rst_n,
    input  [7:0] ascii,
    input  [2:0] x,
    input  [3:0] y,
    output b
);
reg  [  6:0] addr = 7'h0;
reg  [127:0] ch = 128'h0;

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        addr <= 7'h0;
    else
        addr <= ~{y,x};

assign b = ch[addr];

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        ch <= 128'h0;
    else
        case(ascii)
            33:  ch <= 128'h00000018181818181808000818000000; //!0
            34:  ch <= 128'h00000034242424000000000000000000; //"1
            35:  ch <= 128'h0000000016247F2424247E2424000000; //#2
            36:  ch <= 128'h000000083E6848681C1612127C101000; //$3
            37:  ch <= 128'h00000061D296740810162949C6000000; //%4
            38:  ch <= 128'h000000003C646438724ACE467F000000; //&5
            39:  ch <= 128'h00000018181818000000000000000000; //'6
            40:  ch <= 128'h00000004081810303030301010180C04; //(7
            41:  ch <= 128'h000000201008080C0404040C08181020; //)8
            42:  ch <= 128'h000000080A341C6A0800000000000000; //*9
            43:  ch <= 128'h0000000000001818187F181818000000; //+10
            44:  ch <= 128'h00000000000000000000001818083000; //,11
            45:  ch <= 128'h0000000000000000003C000000000000; //-12
            46:  ch <= 128'h00000000000000000000001818000000; //.13
            47:  ch <= 128'h0000000206040C080810102020400000; ///14
            48:  ch <= 128'h000000003C6642475B7342663C000000; //015
            49:  ch <= 128'h0000000018784808080808087E000000; //116
            50:  ch <= 128'h000000003C460606040810207E000000; //217
            51:  ch <= 128'h000000007C0606043C0202067C000000; //318
            52:  ch <= 128'h000000000C1C14246444FF0404000000; //419
            53:  ch <= 128'h000000007E6060607E0202067C000000; //520
            54:  ch <= 128'h000000001E306048764242623C000000; //621
            55:  ch <= 128'h000000007E0206040C08181030000000; //722
            56:  ch <= 128'h000000003C6242361C6642423C000000; //823
            57:  ch <= 128'h000000003C664242661A020478000000; //924
            58:  ch <= 128'h00000000000018180000001818000000; //:25
            59:  ch <= 128'h00000000000018180000001818083000; //;26
            60:  ch <= 128'h00000000000004183060100C06000000; //<27
            61:  ch <= 128'h00000000000000007E007E0000000000; //=28
            62:  ch <= 128'h000000000000301804060C1020000000; //>29
            63:  ch <= 128'h000000301C0606061810001010000000; //?30
            64:  ch <= 128'h0000001C224141DDB5A5A5AF94C0403C; //@31
            65:  ch <= 128'h00000000181C342426627E43C1000000; //A32
            66:  ch <= 128'h000000007C4642467C4242427C000000; //B33
            67:  ch <= 128'h000000001E204040404040603E000000; //C34
            68:  ch <= 128'h000000007C4642434343424678000000; //D35
            69:  ch <= 128'h000000007E6060607E6060607E000000; //E36
            70:  ch <= 128'h000000007E6060607E60606060000000; //F37
            71:  ch <= 128'h000000001E604040CE4242623E000000; //G38
            72:  ch <= 128'h00000000424242427E42424242000000; //H39
            73:  ch <= 128'h000000007E181818181818187E000000; //I40
            74:  ch <= 128'h000000007C0404040404044478000000; //J41
            75:  ch <= 128'h000000004244485070584C4442000000; //K42
            76:  ch <= 128'h0000000020202020202020203E000000; //L43
            77:  ch <= 128'h000000006266675F5B5BC1C1C1000000; //M44
            78:  ch <= 128'h00000000626272525A4A4E4646000000; //N45
            79:  ch <= 128'h000000003C6243C3C3C343623C000000; //O46
            80:  ch <= 128'h000000007C4642424678404040000000; //P47
            81:  ch <= 128'h000000003C6243C3C3C343623C180F00; //Q48
            82:  ch <= 128'h000000007C6662667C6C646662000000; //R49
            83:  ch <= 128'h000000003E6040601C0602027C000000; //S50
            84:  ch <= 128'h000000007F1818181818181818000000; //T51
            85:  ch <= 128'h0000000042424242424242623C000000; //U52
            86:  ch <= 128'h00000000C14342622624341C18000000; //V53
            87:  ch <= 128'h00000000C1C141495B5B766666000000; //W54
            88:  ch <= 128'h0000000043663418181C2466C3000000; //X55
            89:  ch <= 128'h00000000C14266341C18181818000000; //Y56
            90:  ch <= 128'h000000007E02040C181020607E000000; //Z57
            91:  ch <= 128'h0000001C10101010101010101010101C; //[58
            92:  ch <= 128'h000000402020101008080C0406020000; //\59
            93:  ch <= 128'h0000003C0C0C0C0C0C0C0C0C0C0C0C3C; //]60
            94:  ch <= 128'h00000000181C24620000000000000000; //^61
            95:  ch <= 128'h000000000000000000000000000000FF; //_62
            96:  ch <= 128'h00000020100000000000000000000000; //`63
            97:  ch <= 128'h0000000000003C06023E42467A000000; //a64
            98:  ch <= 128'h0000004040405C62424242427C000000; //b65
            99:  ch <= 128'h0000000000001E20604060203E000000; //c66
            100: ch <= 128'h0000000202023E62424242663A000000; //d67
            101: ch <= 128'h0000000000003C62427E40603E000000; //e68
            102: ch <= 128'h0000000F1810107E1010101010000000; //f69
            103: ch <= 128'h0000000000003F66426658403E43423C; //g70
            104: ch <= 128'h0000004040405C624242424242000000; //h71
            105: ch <= 128'h0000001818007808080808087E000000; //i72
            106: ch <= 128'h000000040C007C040404040404040C78; //j73
            107: ch <= 128'h000000606060626C7870686462000000; //k74
            108: ch <= 128'h0000007808080808080808087E000000; //l75
            109: ch <= 128'h000000000000764B4B4B4B4B4B000000; //m76
            110: ch <= 128'h0000000000005C624242424242000000; //n77
            111: ch <= 128'h0000000000003C62424342623C000000; //o78
            112: ch <= 128'h0000000000005C62424242427C404040; //p79
            113: ch <= 128'h0000000000003E62424242663A020202; //q80
            114: ch <= 128'h0000000000006E726360606060000000; //r81
            115: ch <= 128'h0000000000003E20203C06027C000000; //s82
            116: ch <= 128'h000000001010FE10101010101E000000; //t83
            117: ch <= 128'h0000000000004242424242663A000000; //u84
            118: ch <= 128'h00000000000043426624341818000000; //v85
            119: ch <= 128'h000000000000C1C15B5A5E6666000000; //w86
            120: ch <= 128'h00000000000062261C181C2662000000; //x87
            121: ch <= 128'h00000000000043426624341C181830E0; //y88
            122: ch <= 128'h0000000000007E060C1810207E000000; //z89
            123: ch <= 128'h0000000E18101010307010101010180E; //{90
            124: ch <= 128'h00000808080808080808080808080808; //|91
            125: ch <= 128'h00000030180808080C0E080808081830; //}92
            126: ch <= 128'h0000000000000000714B060000000000; //~93
            default ch <= 128'h0;
        endcase

endmodule
