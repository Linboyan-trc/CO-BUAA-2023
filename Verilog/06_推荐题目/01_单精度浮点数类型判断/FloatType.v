module FloatType (
    input [31:0]num,
    output [4:0]float_type
);
    
assign float_type = ((num[30:23]==8'd0)&&(num[22:0]==23'd0))?5'b0_0001:
                    ((num[30:23]==8'd0)&&(num[22:0]!=23'd0))?5'b0_0100:
                    ((num[30:23]!=8'd0)&&(num[30:23]!=8'b1111_1111))?5'b0_0010:
                    ((num[30:23]==8'b1111_1111)&&(num[22:0]==23'd0))?5'b0_1000:
                    5'b1_0000;

endmodule