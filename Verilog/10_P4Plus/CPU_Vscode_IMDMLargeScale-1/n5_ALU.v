/*输入:
    A B ALUOp
    输出：C isEqual
*/
/*ALUOp:
    000:+
    001:-
    010:空
    011:|
    100:lui
*/
module ALU(
    input [31:0] A,B,
    input [2:0] ALUOp,

    output [31:0] C,
    output isEqual
);
    //根据ALUOp输出C
    assign C =  (ALUOp==3'b000)?A+B:
                (ALUOp==3'b001)?A-B:
                (ALUOp==3'b010)?A^B:
                (ALUOp==3'b011)?A|B:
                (ALUOp==3'b100)?B<<16:
                32'd0;
    //输出isEqual
    assign isEqual= (A==B)?1:0;
endmodule 
