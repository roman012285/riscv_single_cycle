`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// THIS PART IMPLEMENTS ONE PORT INSTRUCTION RAM OF RISC-V (32I) ISA
// Designer is a member of ENICS LABS at Bar - Ilan university
// Designer contacts : Roman Gilgor. roman329@gmail.com
//////////////////////////////////////////////////////////////////////////////////

`include "defines.v"

module inst_ram(
     input  [$clog2(`INST_DEPTH)-1:0]  addra,
     input                             clka,
     input  [`INST_SIZE-1:0]           dina, 
     output [`INST_SIZE-1:0]           douta,
     input                             ena,
     input                             wea
);

    // This is distributed RAM. To create block ram use IP or add register to output
    // possible to use (*ram_style = block"*) after creating output reg 
    reg [`INST_SIZE-1:0] inst_ram [0:`INST_DEPTH-1];
    
    
    always @(posedge clka) begin
        if(ena & wea)
            inst_ram[addra] <= dina;
    end 
    
    assign douta = (ena) ? inst_ram[addra] : 0;
    
endmodule
