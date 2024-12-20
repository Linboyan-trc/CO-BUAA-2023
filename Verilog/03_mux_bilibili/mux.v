/*功能描述
    sel=00 输出a&b
    sel=01 输出a|b
    sel=10 输出a^b
    sel=11 输出~(a^b)
 
    输入：3个 a b sel;其中sel位宽为2
    输出：1个 y
*/
module mux(
        input a,b,
        input [1:0]sel,

        output y
    );

    //always语句赋值用reg
    reg y;

    always @(*) begin
        case (sel)
            2'b 00:
                y=a&b;
            2'b 01:
                y=a|b;
            2'b 10:
                y=a^b;
            2'b 11:
                y=~(a^b);
            endcase
    end

endmodule
