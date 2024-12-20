//用myString存输入的字符串
/*要用myString = myString<<8 | ( in | 8'h20 ) 来阻塞赋值myString，使得in的输入myString的更新同步
    样例中：在输入"n"上升沿就刷新了输出，所以用=
    如果为：在输入"n'的下降沿才刷新输出，就用<=来更新myString
*/
/*设置stackTop来判断配对情况
    stackTop<=-1 先出现了end，记录到flag中直接永远输出0，直到下一次reset
    stackTop==0 配对成功
    stackTop>=1 配对中
*/
//【注】本题会存在beginX这种情况，输入begin时有效，变成beginX后无效
//所以要考虑beginX时，对stackTop返回在上一个上升沿进栈的begin退栈
//同理也要考虑到begin必须有前导空格，即一个有效的begin其实是7个字符，" begin "
module BlockChecker (
    input clk,reset,
    input [7:0]in,
    output result
);

   //需要准备：myString、stackTop和负栈flag
   //单词数最多是2^32，所以stackTop作为配对计数器要考虑前面一直输入begin，后面一直输入end的配对情况
   //所以stackTop设置为[31:0]
   //负栈flag初始化默认为1，如果负栈后置为0，让result一直输出0直到reset
   reg [255:0]myString;
   reg [31:0]stackTop;
   reg flag;

   //对自己定义的东西要初始化
   initial begin
        myString="";
        stackTop<=0;
        flag<=1'b1;
   end

    //上升沿+复位
    always @(posedge clk,posedge reset)begin
        if(reset)begin
            myString="";
            stackTop<=0;
            flag<=1'b1;
        end
        else begin

            //更新in到myString中，然后逻辑判断
            myString = myString<<8 | (in|8'h20);

            //逻辑判断，增减栈+是否负栈
            if(myString[47:0]==" begin")stackTop <= stackTop+1;
            else if(myString[55:8]==" begin" && myString[7:0]!=" ")stackTop <= stackTop-1;
            else if(myString[31:0]==" end")stackTop <= stackTop-1;
            else if(myString[39:8]==" end" && myString[7:0]!=" ")stackTop <= stackTop+1;
            else if(myString[39:0]==" end "&&stackTop[31]==1)flag<=1'b0;
        end
    end

    assign result = ((stackTop==0)&flag);

endmodule
