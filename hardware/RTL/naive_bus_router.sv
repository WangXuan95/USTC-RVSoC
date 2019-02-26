module naive_bus_router #(
    parameter [7:0] N_MASTER = 2,
    parameter [7:0] N_SLAVE = 3,
    parameter [0:N_SLAVE-1][31:0] SLAVES_MASK = { 32'h0000_3fff , 32'h0000_3fff , 32'h0000_3fff },
    parameter [0:N_SLAVE-1][31:0] SLAVES_BASE = { 32'h0000_0000 , 32'h0001_0000 , 32'h0002_0000 }
)(
    input  logic        clk, rst_n,
    naive_bus.slave     masters  [N_MASTER-1:0] ,
    naive_bus.master    slaves   [ N_SLAVE-1:0]
);

`define SLAVE_ADDRESS(master_addr, slave_index)    (master_addr) & ( SLAVES_MASK[slave_index] )
`define SLAVE_INRANGE(master_addr, slave_index) ( ((master_addr) & (~SLAVES_MASK[slave_index]))==(SLAVES_BASE[slave_index]) )

logic [N_MASTER-1:0]       masters_rd_req;
logic [N_MASTER-1:0][ 3:0] masters_rd_be;
logic [N_MASTER-1:0][31:0] masters_rd_addr;
logic [N_MASTER-1:0]       masters_wr_req;
logic [N_MASTER-1:0][ 3:0] masters_wr_be;
logic [N_MASTER-1:0][31:0] masters_wr_addr;
logic [N_MASTER-1:0][31:0] masters_wr_data;
logic [N_MASTER-1:0]       masters_rd_gnt = 1'b0;
logic [N_MASTER-1:0][ 7:0] master_rd_slv_index       = {N_MASTER{N_SLAVE}};
logic [N_MASTER-1:0][ 7:0] master_rd_slv_index_latch = {N_MASTER{N_SLAVE}};
logic [N_MASTER-1:0][ 7:0] slv                       = {N_MASTER{N_SLAVE}};

logic [N_SLAVE-1:0]        slaves_wr_gnt, slaves_rd_gnt;
logic [N_SLAVE-1:0][ 7:0]  mst                 = {N_SLAVE{N_MASTER}};
logic [N_SLAVE-1:0][ 7:0]  slaves_wr_mst_index = {N_SLAVE{N_MASTER}};
logic [N_SLAVE-1:0][ 7:0]  slaves_rd_mst_index = {N_SLAVE{N_MASTER}};
logic [N_SLAVE  :0][31:0]  slaves_rd_data;


assign slaves_rd_data[N_SLAVE] = 0;

generate
    genvar slv_i_assign;
    for(slv_i_assign=0; slv_i_assign<N_SLAVE; slv_i_assign++) begin: assign_slaves
        assign slaves_wr_gnt[slv_i_assign] = slaves[slv_i_assign].wr_gnt;
        assign slaves_rd_gnt[slv_i_assign] = slaves[slv_i_assign].rd_gnt;
        assign slaves_rd_data[slv_i_assign]= slaves[slv_i_assign].rd_data;
    end
endgenerate

generate
    genvar mst_i_assign;
    for(mst_i_assign=0; mst_i_assign<N_MASTER; mst_i_assign++) begin: assign_masters
        assign masters_rd_req [mst_i_assign] = masters[mst_i_assign].rd_req;
        assign masters_rd_be  [mst_i_assign] = masters[mst_i_assign].rd_be;
        assign masters_rd_addr[mst_i_assign] = masters[mst_i_assign].rd_addr;
        assign masters_wr_req [mst_i_assign] = masters[mst_i_assign].wr_req;
        assign masters_wr_be  [mst_i_assign] = masters[mst_i_assign].wr_be;
        assign masters_wr_addr[mst_i_assign] = masters[mst_i_assign].wr_addr;
        assign masters_wr_data[mst_i_assign] = masters[mst_i_assign].wr_data;
        assign masters[mst_i_assign].rd_gnt  = masters_rd_gnt[mst_i_assign];
        assign masters[mst_i_assign].rd_data = slaves_rd_data[master_rd_slv_index_latch[mst_i_assign]];
    end
endgenerate

generate
    genvar slv_i;
    for(slv_i=0; slv_i<N_SLAVE; slv_i++) begin: generate_slave_loop
        always_comb begin
            slaves[slv_i].rd_req  = 1'b0;
            slaves[slv_i].rd_be   = 4'h0;
            slaves[slv_i].rd_addr = 0;
            slaves_rd_mst_index[slv_i] = N_MASTER;
            slaves[slv_i].wr_req  = 1'b0;
            slaves[slv_i].wr_be   = 4'h0;
            slaves[slv_i].wr_addr = 0;
            slaves[slv_i].wr_data = 0;
            slaves_wr_mst_index[slv_i] = N_MASTER;
            for(mst[slv_i]=0; mst[slv_i]<N_MASTER; mst[slv_i]+=1) begin
                if( `SLAVE_INRANGE(masters_rd_addr[mst[slv_i]], slv_i) & masters_rd_req[mst[slv_i]] ) begin
                    slaves[slv_i].rd_req  = 1'b1;
                    slaves[slv_i].rd_be   = masters_rd_be[mst[slv_i]];
                    slaves[slv_i].rd_addr = `SLAVE_ADDRESS(masters_rd_addr[mst[slv_i]], slv_i);
                    slaves_rd_mst_index[slv_i] = mst[slv_i];
                end
                if( `SLAVE_INRANGE(masters_wr_addr[mst[slv_i]], slv_i) & masters_wr_req[mst[slv_i]] ) begin
                    slaves[slv_i].wr_req  = 1'b1;
                    slaves[slv_i].wr_be   = masters_wr_be[mst[slv_i]];
                    slaves[slv_i].wr_addr = `SLAVE_ADDRESS(masters_wr_addr[mst[slv_i]], slv_i);
                    slaves[slv_i].wr_data = masters_wr_data[mst[slv_i]];
                    slaves_wr_mst_index[slv_i] = mst[slv_i];
                end
            end
        end
    end
endgenerate

generate
    genvar mst_i;
    for(mst_i=0; mst_i<N_MASTER; mst_i++) begin: generate_master_loop
        always_comb begin
            masters[mst_i].wr_gnt = 1'b1; 
            masters_rd_gnt[mst_i] = 1'b1;
            master_rd_slv_index[mst_i] = N_SLAVE;
            for(slv[mst_i]=0; slv[mst_i]<N_SLAVE; slv[mst_i]+=1) begin
                if( `SLAVE_INRANGE(masters_rd_addr[mst_i], slv[mst_i]) ) begin
                    masters_rd_gnt[mst_i] = (slaves_rd_mst_index[slv[mst_i]]==mst_i) ? slaves_rd_gnt[slv[mst_i]] : 1'b0;
                    master_rd_slv_index[mst_i] = masters_rd_gnt[mst_i] ? slv[mst_i] : N_SLAVE;
                end
                if( `SLAVE_INRANGE(masters_wr_addr[mst_i], slv[mst_i]) ) begin
                    masters[mst_i].wr_gnt = (slaves_wr_mst_index[slv[mst_i]]==mst_i) ? slaves_wr_gnt[slv[mst_i]] : 1'b0;
                end
            end
        end
    end
endgenerate

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        master_rd_slv_index_latch <= {N_MASTER{N_SLAVE}};
    else
        master_rd_slv_index_latch <= master_rd_slv_index;

endmodule
