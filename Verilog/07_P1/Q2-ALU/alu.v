module alu (
    input [31:0]A,B,
    input [2:0]ALUOp,
    output [31:0]C
);
    //verilog中除了integer外，信号默认都是无符号
    wire [31:0]temp=$signed(A)>>>B;
    assign C =  (ALUOp==3'd0)?A+B:
                (ALUOp==3'd1)?A-B:
                (ALUOp==3'd2)?A&B:
                (ALUOp==3'd3)?A|B:
                (ALUOp==3'd4)?A>>B:
                (ALUOp==3'd5)?temp:
                32'd0;
endmodule