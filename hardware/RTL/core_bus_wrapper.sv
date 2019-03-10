module core_bus_wrapper(
    input  logic clk, rst_n,
    input  logic i_re, i_we,
    output logic o_conflict,
    input  logic [ 2:0] i_funct3,
    input  logic [31:0] i_addr,
    input  logic [31:0] i_wdata,
    output logic [31:0] o_rdata,
    
    naive_bus.master  bus_master
);

logic i_re_latch=1'b0, o_conflict_latch=1'b0;
logic [1:0]  addr_lsb, rd_addr_lsb=2'b0;
logic [31:0] addr_bus, wdata, rdata, rdata_latch=0;
logic [2:0]  rd_funct3=3'b0;
logic [3:0]  byte_enable;

assign addr_bus = {i_addr[31:2], 2'b0};
assign addr_lsb = i_addr[1:0];

assign o_conflict = (bus_master.rd_req & ~bus_master.rd_gnt) | (bus_master.wr_req & ~bus_master.wr_gnt);

assign bus_master.rd_req  = i_re;
assign bus_master.rd_be   = i_re ? byte_enable : 4'h0;
assign bus_master.rd_addr = i_re ? addr_bus : 0;
assign rdata = bus_master.rd_data;

assign bus_master.wr_req  = i_we;
assign bus_master.wr_be   = i_we ? byte_enable : 4'h0;
assign bus_master.wr_addr = i_we ? addr_bus : 0;
assign bus_master.wr_data = i_we ? wdata : 0;


always_comb
    casex(i_funct3)
        3'bx00    : if     (addr_lsb==2'b00) byte_enable <= 4'b0001;
                    else if(addr_lsb==2'b01) byte_enable <= 4'b0010;
                    else if(addr_lsb==2'b10) byte_enable <= 4'b0100;
                    else                     byte_enable <= 4'b1000;
        3'bx01    : if     (addr_lsb==2'b00) byte_enable <= 4'b0011;
                    else if(addr_lsb==2'b10) byte_enable <= 4'b1100;
                    else                     byte_enable <= 4'b0000;
        3'b010    : if     (addr_lsb==2'b00) byte_enable <= 4'b1111;
                    else                     byte_enable <= 4'b0000;
        default   :                          byte_enable <= 4'b0000;
    endcase


always_comb
    case(i_funct3)
        3'b000    : if     (addr_lsb==2'b00) wdata <= {24'b0, i_wdata[7:0]};
                    else if(addr_lsb==2'b01) wdata <= {16'b0, i_wdata[7:0], 8'b0};
                    else if(addr_lsb==2'b10) wdata <= {8'b0, i_wdata[7:0], 16'b0};
                    else                     wdata <= {i_wdata[7:0], 24'b0};
        3'b001    : if     (addr_lsb==2'b00) wdata <= {16'b0, i_wdata[15:0]};
                    else if(addr_lsb==2'b10) wdata <= {i_wdata[15:0], 16'b0};
                    else                     wdata <= 0;
        3'b010    : if     (addr_lsb==2'b00) wdata <= i_wdata;
                    else                     wdata <= 0;
        default   :                          wdata <= 0;
    endcase
    

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        i_re_latch  <= 1'b0;
        rd_addr_lsb <= 2'b0;
        rd_funct3   <= 3'b0;
        o_conflict_latch <= 1'b0;
        rdata_latch <= 0;
    end else begin
        i_re_latch  <= i_re;
        rd_addr_lsb <= addr_lsb;
        rd_funct3   <= i_funct3;
        o_conflict_latch <= o_conflict;
        rdata_latch <= o_rdata;
    end

// assign o_rdata
always_comb
    if(i_re_latch) begin
        if(~o_conflict_latch)
            case(rd_funct3)
            3'b000    : if     (rd_addr_lsb==2'b00) o_rdata <= {{24{rdata[ 7]}}, rdata[ 7: 0]};
                        else if(rd_addr_lsb==2'b01) o_rdata <= {{24{rdata[15]}}, rdata[15: 8]};
                        else if(rd_addr_lsb==2'b10) o_rdata <= {{24{rdata[23]}}, rdata[23:16]};
                        else                        o_rdata <= {{24{rdata[31]}}, rdata[31:24]};
            3'b100    : if     (rd_addr_lsb==2'b00) o_rdata <= {          24'b0, rdata[ 7: 0]};
                        else if(rd_addr_lsb==2'b01) o_rdata <= {          24'b0, rdata[15: 8]};
                        else if(rd_addr_lsb==2'b10) o_rdata <= {          24'b0, rdata[23:16]};
                        else                        o_rdata <= {          24'b0, rdata[31:24]};
            3'b001    : if     (rd_addr_lsb==2'b00) o_rdata <= {{16{rdata[15]}}, rdata[15: 0]};
                        else if(rd_addr_lsb==2'b10) o_rdata <= {{16{rdata[31]}}, rdata[31:16]};
                        else                        o_rdata <= 0;
            3'b101    : if     (rd_addr_lsb==2'b00) o_rdata <= {          16'b0, rdata[15: 0]};
                        else if(rd_addr_lsb==2'b10) o_rdata <= {          16'b0, rdata[31:16]};
                        else                        o_rdata <= 0;
            3'b010    : if     (rd_addr_lsb==2'b00) o_rdata <= rdata;
                        else                        o_rdata <= 0;
            default   :                             o_rdata <= 0;
            endcase
        else
            o_rdata <= 0;
    end else begin
        o_rdata <= rdata_latch;
    end

endmodule
