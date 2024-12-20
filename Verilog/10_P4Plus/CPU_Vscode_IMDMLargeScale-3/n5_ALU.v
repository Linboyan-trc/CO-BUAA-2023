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
    //计算
    reg [31:0]temp;
    integer i;
    always@(*)begin
        //如果是op=010才计算
        if(ALUOp==3'b010)begin
            for(i=0;i<B;i=i+1)begin
                temp[i]=~A[i];
            end
            for(i=B;i<32;i++)begin
                temp[i]=A[i];
            end
        end
        else begin
            temp = 32'd0;
        end
    end
    //根据ALUOp输出C
    assign C =  (ALUOp==3'b000)?A+B:
                (ALUOp==3'b001)?A-B:
                (ALUOp==3'b010)?temp:
                (ALUOp==3'b011)?A|B:
                (ALUOp==3'b100)?B<<16:
                32'd0;
    //输出isEqual
    assign isEqual= (A==B)?1:0;
endmodule 
