module ALU(
    input [31:0] A,B,
    input [2:0] ALUOp,

    output [31:0] C
);
    //根据ALUOp输出C
    //swc
    reg [31:0] A_swc;
    integer i;
    always @(*) begin
        A_swc = A;
        if(B[0]==1'b1)begin//奇数
            for(i=0;i<B[4:0];i=i+1)begin
                A_swc = {A_swc[30:0], A_swc[31]};
            end
        end
        else begin//偶数
            for(i=0;i<B[4:0];i=i+1)begin
                A_swc = {A_swc[0],A_swc[31:1]};
            end
        end
    end
    assign C =  (ALUOp==3'b000)?A+B:
                (ALUOp==3'b001)?A-B:
                (ALUOp==3'b010)?A_swc:
                (ALUOp==3'b011)?A|B:
                (ALUOp==3'b100)?B<<16:
                32'd0;

endmodule 
