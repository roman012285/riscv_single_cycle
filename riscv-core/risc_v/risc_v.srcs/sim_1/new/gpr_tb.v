`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// THIS PART IMPLEMENTS REGISTER FILE TB OF RISC-V (32I) ISA
// Designer is a member of ENICS LABS at Bar - Ilan university
// Designer contacts : Roman Gilgor. roman329@gmail.com
//////////////////////////////////////////////////////////////////////////////////



module gpr_tb(
);

    localparam DELAY       = 5;
    localparam REG_WIDTH   = 32;
    localparam GPRN        = 32;
    localparam N_BYTES     = 16;

    reg                       clk;
    reg                       we;
    reg                       en;
    reg  [$clog2(GPRN)-1:0]  addr_rs1;
    reg  [$clog2(GPRN)-1:0]  addr_rs2;
    reg  [$clog2(GPRN)-1:0]  addr_rd;
    reg  [REG_WIDTH-1:0]     data_rd;
    wire [REG_WIDTH-1:0]     data_rs1;
    wire [REG_WIDTH-1:0]     data_rs2;
    
    gpr gpt_tb(
        .clk(clk),
        .we(we),
        .en(en),
        .addr_rs1(addr_rs1),
        .addr_rs2(addr_rs2),
        .addr_rd(addr_rd),
        .data_rd(data_rd),
        .data_rs1(data_rs1),
        .data_rs2(data_rs2)
    );
    
    always #DELAY clk = !clk;
    
    
    integer i;
    initial begin
        $display("MEMORY INIZIALIZATION");
        $display("---------------------");
        clk = 0;
        en = 1;
        we = 1;
        #DELAY;
        
        for (i=0; i<N_BYTES; i=i+1) begin
            addr_rd  = i;
            data_rd  = i+1;
            #(2*DELAY);        
        end
        
        $display("FINISH MEMORY INIZIALIZATION");
        $display("----------------------------");
        #DELAY;
    end
    
    
    integer j,k;
    initial begin
        #(100*DELAY);
        $display("READING MEMORY");
        $display("--------------");
        en = 1;
        we = 0;
        #DELAY;
        
         $display("READING FROM RS1 PORT");
         $display("---------------------");
         #DELAY;
         
         for (j=0; j<N_BYTES; j=j+1) begin
            addr_rs1 = j;
            #DELAY;
            $display("GPR_X%1d = %h\n", j, data_rs1);
            #DELAY;        
        end
        
        $display("READING FROM RS2 PORT");
        $display("---------------------");
        #DELAY;
         
        for (k=0; k<N_BYTES; k=k+1) begin
            addr_rs2 = k;
            #DELAY;
            $display("GPR_X%1d = %h\n", k, data_rs2);
            #DELAY;        
        end
        
        $finish();
    end
endmodule
