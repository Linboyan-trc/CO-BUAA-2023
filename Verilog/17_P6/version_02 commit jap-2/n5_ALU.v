module ALU(
    input [31:0] A,B,
    input [3:0] ALUOp,

    output [31:0] C
);
    //slt 和 sltu
    wire isSlt;
    assign isSlt = $signed(A) < $signed(B);
    wire isSltu;
    assign isSltu = A < B;
    //根据ALUOp输出C
    assign C =  (ALUOp==4'd0)?  A+B:
                (ALUOp==4'd1)?  A-B:
                (ALUOp==4'd2)?  A&B:
                (ALUOp==4'd3)?  A|B:
                (ALUOp==4'd4)?  B<<16:
                (ALUOp==4'd5)?  {31'd0,isSlt}:
                (ALUOp==4'd6)?  {31'd0,isSltu}:
                (ALUOp==4'd7)?  A:
                                32'd0;

endmodule 
