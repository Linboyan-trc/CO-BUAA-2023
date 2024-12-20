module tb (
);
//接线
    reg [31:0]A,B;
    reg [2:0]ALUOp;
    wire [31:0]C;
    alu myAlu(
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .C(C)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
//时钟
    initial begin
        A=32'hf001;
        B=32'h0004;
        #10 $finish;
    end
//控制输入
    initial begin
        ALUOp=3'd0;
        #1;
        ALUOp=3'd1;
        #1;
        ALUOp=3'd2;
        #1;
        ALUOp=3'd3;
        #1;
        ALUOp=3'd4;
        #1;
        ALUOp=3'd5;
        #1;
    end
//
endmodule



