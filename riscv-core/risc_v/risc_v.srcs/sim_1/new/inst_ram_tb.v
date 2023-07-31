`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// THIS PART IMPLEMENTS ONE PORT INSTRUCTION RAM TB OF RISC-V (32I) ISA
// Designer is a member of ENICS LABS at Bar - Ilan university
// Designer contacts : Roman Gilgor. roman329@gmail.com
//////////////////////////////////////////////////////////////////////////////////


module inst_ram_tb(
);

    localparam DELAY      = 5;
    localparam INST_DEPTH = 1024;
    localparam INST_SIZE  = 32;
    
    
    reg  [$clog2(INST_DEPTH)-1:0]  addra;
    reg                            clka;
    reg  [INST_SIZE-1:0]           dina; 
    wire [INST_SIZE-1:0]           douta;
    reg                            ena;
    reg                            wea;
     
     inst_ram ins_ram(
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea)
     ); 
    
    always #DELAY clka = !clka;
    
    localparam N_BYTES = 16;
    
    integer i;
    initial begin
        $display("MEMORY INIZIALIZATION");
        $display("---------------------");
        clka = 0;
        ena = 1;
        wea = 1;
        #DELAY;
        
        for (i=0; i<N_BYTES; i=i+1) begin
            addra = i;
            dina  = 2*i;
            #(2*DELAY);        
        end
        
        $display("FINISH MEMORY INIZIALIZATION");
        $display("----------------------------");
        #DELAY;
    end
    
    
    integer j;
    initial begin
        #(100*DELAY);
        $display("READING MEMORY");
        $display("--------------");
        ena = 1;
        wea = 0;
        #DELAY;
        
 
         for (j=0; j<N_BYTES; j=j+1) begin
            addra = j;
            #DELAY;
            $display("INST_RAM[%h] = %h\n", j, douta);
            #DELAY;        
        end
        
        $finish();
    end
endmodule
