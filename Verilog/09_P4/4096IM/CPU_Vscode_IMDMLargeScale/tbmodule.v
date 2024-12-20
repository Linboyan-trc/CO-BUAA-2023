// `include "./mips.v"
module tb (
);
//接线
    reg [31:0]A,B;
    reg [2:0]ALUOp;
    wire [31:0]C;
    wire isEqual;
    ALU u_ALU(
        .A       	( A        ),
        .B       	( B        ),
        .ALUOp   	( ALUOp    ),
        .C       	( C        ),
        .isEqual 	( isEqual  )
    );
    
//生成文件
    initial begin
        $dumpfile("referencemodule.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        A=32'h00000000;
        B=32'h0000ffff;
        ALUOp=3'b011;
        #2 $finish;
    end
// //时钟
//     always#1 clk=~clk;
endmodule



