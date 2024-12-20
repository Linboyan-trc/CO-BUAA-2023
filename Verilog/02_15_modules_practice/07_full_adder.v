//1'b全加器，教程给的32位的，我看不懂
module full_adder(
    input a,b,cin,
    output s,cout;
);

assign{cout,s}=a+b+cin; //如果加出来是11那么cout=1 s=1
                        //如果加出来是10那么cout=1 s=0

endmodule