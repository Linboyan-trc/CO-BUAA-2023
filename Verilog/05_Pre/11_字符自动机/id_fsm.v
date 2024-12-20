//输入:字符char 时钟clk 输出：out
/*三个状态
    状态1：输入的不是字母
        1.num           保持状态1
        2.alpha         去到状态2
        3.非alpha num   保持状态1
    状态2：字母
        1.num           去到状态3
        2.alpha         保持状态2
        3.非alpha num   去到状态1
    状态3：数字
        1.num           保持状态3
        2.alpha         回到状态2
        3.非alpha num   去到状态1
*/
`define S_00   2'b00
`define S_01   2'b01
`define S_02   2'b10
module id_fsm (
        input [7:0]char,
        input clk,
        output out
    );
    //初始化状态
    reg [1:0]status;
    initial
        status<=`S_00;
    //根据输入的char和当前状态转移状态
    //字母：[65,90] [97,122]    数字：[48,57]
    always@(posedge clk) begin
        case (status)
            `S_00: begin
                status<=((char>=48)&&(char<=57))?`S_00:
                    (((char>=65)&&(char<=90))||((char>=97)&&(char<=122)))?`S_01:
                    `S_00;
                    end
            `S_01: begin
                status<=((char>=48)&&(char<=57))?`S_02:
                    (((char>=65)&&(char<=90))||((char>=97)&&(char<=122)))?`S_01:
                    `S_00;
                    end
            `S_02: begin
                status<=((char>=48)&&(char<=57))?`S_02:
                    (((char>=65)&&(char<=90))||((char>=97)&&(char<=122)))?`S_01:
                    `S_00;
                    end
        endcase
    end
    //判断输出
    assign out=(status==`S_02)?1'b1:1'b0;
endmodule
