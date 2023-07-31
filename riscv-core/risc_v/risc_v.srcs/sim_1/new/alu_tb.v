`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// THIS PART IMPLEMENTS ALU_TB CORE FOR RISC-V (32I) ISA
// Designer is a member of ENICS LABS at Bar - Ilan university
// Designer contacts : Roman Gilgor. roman329@gmail.com
// op-code - IR[30] + IR[14:12] 
// flag    - zero, less(unsigned), less(signed)
// 0000 - add
// 1000 - sub
// 0001 - sll
// 0010 - slt
// 0011 - sltu
// 0100 - xor
// 0101 - srl
// 1101 - sra
// 0110 - or
// 0111 - and
//////////////////////////////////////////////////////////////////////////////////


module alu_tb(
);
    localparam DELAY = 10;
    
    localparam WIDTH     = 32;
    localparam FLGAN     = 3;
    localparam FUNC_SIZE = 4;
        
    reg  [FUNC_SIZE-1:0]  func_code;
    wire [WIDTH-1:0]      result;
    wire [FLGAN-1:0]      flag;
    reg  [WIDTH-1:0]      in1, in2;
    
 alu alu_unit (
    .func_code(func_code),
    .in1(in1),
    .in2(in2),
    .result(result),
    .flag(flag)      
);

    initial begin
        in1 = 32'h00000100;
        in2 = 32'h00000004;
        
        $display("STARTING TEST");
        $display("ALL RESULT IN HEXADECIMAL BASE AND NOT!!!!! IN BINARY");
        $display("CASE1 IN1>IN2 - BOTH POSITIVE");
        $display("-----------------------------------------------------");
        
        // TEST ADD //
        func_code =  4'b0000;
        #DELAY;
        $display("TESTING ADD : the result of %h + %h is: %h \n\n", in1, in2, result);
        
       
        // TEST SUB //
        func_code =  4'b1000;
        #DELAY;
        $display("TESTING SUB(1/2) : the result of %h - %h is: %h \n\n", in1, in2, result);
        
        // TEST SLL //
        func_code =  4'b0001;
        #DELAY;
        $display("TESTING SLL : the result of %h << %h is: %h \n\n", in1, in2, result);
        
        // TEST SLT //
        func_code =  4'b0010;
        #DELAY;
        $display("TESTING SLT(1/5) : the result of %h SLT %h is: %h \n\n", in1, in2, result);
        
        // TEST SLTU //
        func_code =  4'b0011;
        #DELAY;
        $display("TESTING SLTU(1/5) : the result of %h SLTU %h is: %h \n\n", in1, in2, result);
        
        // TEST XOR //
        func_code =  4'b0100;
        #DELAY;
        $display("TESTING XOR : the result of %h XOR %h is: %h \n\n", in1, in2, result);
        
        // TEST SRL //
        func_code =  4'b0101;
        #DELAY;
        $display("TESTING SRL(1/2) : the result of %h SRL %h is: %h \n\n", in1, in2, result);
        
        // TEST SRA //
        func_code =  4'b1101;
        #DELAY;
        $display("TESTING SRA(1/2) : the result of %h SRA %h is: %h \n\n", in1, in2, result);
        
        // TEST OR //
        func_code =  4'b0110;
        #DELAY;
        $display("TESTING OR : the result of %h OR %h is: %h \n\n", in1, in2, result);
        
        // TEST AND //
        func_code =  4'b0111;
        #DELAY;
        $display("TESTING AND : the result of %h AND %h is: %h \n\n", in1, in2, result);
    
        // IN1 < IN2
        in1 = 32'h00000004;
        in2 = 32'h00000006;
        
        $display("CASE2 IN1<IN2"); 
        $display("-------------");
        
        #(DELAY);
             
         // TEST SUB //
        func_code =  4'b1000;
        #DELAY;
        $display("TESTING SUB(2/2) : the result of %h - %h is: %h \n\n", in1, in2, result);
       
        
        // TEST SLT //
        func_code =  4'b0010;
        #DELAY;
        $display("TESTING SLT(2/5) : the result of %h SLT %h is: %h \n\n", in1, in2, result);
        
        // TEST SLTU //
        func_code =  4'b0011;
        #DELAY;
        $display("TESTING SLTU(2/5) : the result of %h SLTU %h is: %h \n\n", in1, in2, result);
         
         
        // IN1 > IN2 both negative 
        in1 = 32'hfffffff6;
        in2 = 32'hfffffff5;
        
        $display("CASE3 IN1>IN2 - BOTH NEGATIVE"); 
        $display("-----------------------------");
        
        // TEST SLT //
         func_code =  4'b0010;
        #DELAY;
        $display("TESTING SLT(3/5) : the result of %h SLT %h is: %h \n\n", in1, in2, result);
        
        // TEST SLTU //
        func_code =  4'b0011;
        #DELAY;
        $display("TESTING SLTU(3/5) : the result of %h SLTU %h is: %h \n\n", in1, in2, result);
        
        #(DELAY) 
        $display("FINISH TEST\n");
        $display("___________\n");
        
        // IN1 < IN2 both negative 
        in1 = 32'hfffffff5;
        in2 = 32'hfffffff6;
        
        $display("CASE4 IN1<IN2 - BOTH NEGATIVE"); 
        $display("-----------------------------");
        
        // TEST SLT //
        func_code =  4'b0010;
        #DELAY;
        $display("TESTING SLT(4/5) : the result of %h SLT %h is: %h \n\n", in1, in2, result);
        
        // TEST SLTU //
        func_code =  4'b0011;
        #DELAY;
        $display("TESTING SLTU(4/5) : the result of %h SLTU %h is: %h \n\n", in1, in2, result);
        
        #(DELAY) 
        $display("FINISH TEST\n");
        $display("___________\n");
        
        // IN1 > IN2. one positive ant other negative 
        in1 = 32'hfffffff5;
        in2 = 32'h00000006;
        
        $display("CASE5 IN1 > IN2. One positive and other negative"); 
        $display("------------------------------------------------");
        
        // TEST SLT //
        func_code =  4'b0010;
        #DELAY;
        $display("TESTING SLT(5/5) : the result of %h SLT %h is: %h \n\n", in1, in2, result);
        
        // TEST SLTU //
        func_code =  4'b0011;
        #DELAY;
        $display("TESTING SLTU(5/5) : the result of %h SLTU %h is: %h \n\n", in1, in2, result);
        
        
         // checking arithmetic shift 
        in1 = 32'hf0000005;
        in2 = 32'h00000002;
        
        $display("CASE6 Checking arithmetic right shift"); 
        $display("-------------------------------------");
        
        // TEST SLT //
        func_code =  4'b1101;
        #DELAY;
        $display("TESTING SRA(2/2) : the result of %h SRA %h is: %h \n\n", in1, in2, result);
        
        // TEST SRL //
        func_code =  4'b0101;
        #(DELAY);
        $display("TESTING SRL(1/2) : the result of %h SRL %h is: %h \n\n", in1, in2, result);
        
         // checking zero flag 
        in1 = 32'h00000005;
        in2 = 32'h00000005;
        
        $display("ZERO FLAG CHECK"); 
        $display("-------------------------------------");
        #(DELAY);
        $display("ZERO FLAG IS: in1 = %h, in2 =  %h and flag is: %h", in1, in2, flag[2]);
        #(DELAY) 
        
        in1 = 32'h00000006;
        in2 = 32'h00000005;
        
        #DELAY;
        $display("ZERO FLAG IS: in1 = %h, in2 =  %h and flag is: %h", in1, in2, flag[2]);
        #(DELAY) 
        
        $display("\nFINISH TEST");
        $display("-----------\n");
        
        $finish();
   
    end
    
    
endmodule
