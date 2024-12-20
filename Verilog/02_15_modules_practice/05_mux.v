//多路选择器，5选1
//但是5选1其实有空闲的可选没有利用上，所以这些空闲的可选要设置一个默认输出值8'b0
//输入有5种 0 1 2 3 4，然后和输出保持位宽统一
//输出这里设置为了8输出，其实过于富裕，但是跟着教程做吧
//选择线路需要3根，因为最大的状态4需要用100三位才能表示
module mux_5_1(
        input [7:0]in0,in1,in2,in3,in4 in5,
        output [7:0]out;
        input [2:0]selection,
    );

    //选择哪个就赋值哪个
    assign out=(selection==3'd0)?in0:
           (selection==3'd1)?in1:
           (selection==3'd2)?in2:
           (selection==3'd3)?in3:
           (selection==3'd4)?in4:
           8'b0;//针对没有落在预设范围内的选择，统一输出8'b0

endmodule
