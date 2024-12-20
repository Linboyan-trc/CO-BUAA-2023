//38译码器 3输入 8输出
//1.端口列表 2.赋值
module decoder_38(
        input   [2:0]   in,
        output  [7:0]   out
    );

    genvar i;
generate for(i=0;i<8;i=i+1) begin: name1
            assign output[i]=(in==i);
        end
    endgenerate

endmodule
