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

    output [31:0] C
);
    //cco
    reg [5:0]temp;
    integer i;
    always @(*) begin
        temp = 0;
        for(i=0;i<32;i=i+1)begin
            if((A[i]==1'b1)&&(B[i]==1'b1))begin
                temp = temp + 1;
            end
        end
    end
    //根据ALUOp输出C
    assign C =  (ALUOp==3'b000)?A+B:
                (ALUOp==3'b001)?A-B:
                (ALUOp==3'b010)?temp:
                (ALUOp==3'b011)?A|B:
                (ALUOp==3'b100)?B<<16:
                32'd0;

endmodule 
