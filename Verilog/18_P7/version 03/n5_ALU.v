module ALU(
    input   [31:0]  A,
    input   [31:0]  B,
    input   [3:0]   ALUOp,

    output  [31:0]  C,
    output          isOverflow
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
                                32'd0;
    //加减溢出判断
    assign isOverflow = 
        (ALUOp==4'd0)?  (C_tmp_1[32]!=C_tmp_1[31]): 
        (ALUOp==4'd1)?  (C_tmp_2[32]!=C_tmp_2[31]):
                        1'b0;
    wire [32:0] C_tmp_1,    C_tmp_2;
    assign C_tmp_1 = {A[31], A} + {B[31], B};
    assign C_tmp_2 = {A[31], A} - {B[31], B};
endmodule 
