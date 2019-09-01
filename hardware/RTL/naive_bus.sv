
interface naive_bus();
    // read interface
    logic  rd_req, rd_gnt;
    logic  [3:0]  rd_be;
    logic  [31:0] rd_addr, rd_data;
    // write interface
    logic  wr_req, wr_gnt;
    logic  [3:0]  wr_be;
    logic  [31:0] wr_addr, wr_data;
    
    modport master(
        output rd_req, rd_be, rd_addr,
        input  rd_data, rd_gnt,
        output wr_req, wr_be, wr_addr, wr_data,
        input  wr_gnt
    );
    
    modport slave(
        input  rd_req, rd_be, rd_addr,
        output rd_data, rd_gnt,
        input  wr_req, wr_be, wr_addr, wr_data,
        output wr_gnt
    );
    
endinterface
