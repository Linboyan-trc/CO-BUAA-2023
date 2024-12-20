//一共0-5+6 7个状态 state为3‘b
module intcheck (
    input clk,reset,
    input [7:0]in,
    output out
);

    //state和存" int "字符串
    reg [2:0]myState;
    reg [55:0]myString;
    initial begin
        myState<=3'd0;
        myString<=56'd0;
    end

    //函数，判断是否是字母、下划线
    function isFirstLetterLegal;
        input [7:0]in;
        isFirstLetterLegal =    (in=="_")?1:
                                (in>="a"&&in<="z")?1:
                                (in>="A"&&in<="Z")?1:
                                0;
    endfunction

    //函数，判断是否是数字、字母、下划线
    function isSuffixLetterLegal;
        input [7:0]in;
        isFirstLetterLegal =    (in=="_")?1:
                                (in>="a"&&in<="z")?1:
                                (in>="A"&&in<="Z")?1:
                                (in>="0"&&in<="9")?1:
                                0;
    endfunction

    always @(posedge clk) begin
        if(reset)begin
            myState<=3'd0;
            myString<=56'd0;
        end
        else begin
            case (myState)
                3'd0:begin
                    myString = myString<<8 | in;
                    if(myString[31:0]=="int "&&(myString[39:32]==" "||myString[39:32]==8'd0))begin
                        myState<=3'd1;
                        myString<=56'd0;
                    end
                    else begin
                        myState<=3'd0;
                    end
                end
                3'd1:begin
                    if(in==" ")begin
                        myState<=3'd1;
                    end
                    else if(isFirstLetterLegal(in))begin
                        myState<=3'd2;
                    end
                    else begin
                        myState<=3'd6;
                    end
                end
                3'd6:begin
                    myState<=3'd6;
                end
                
                default: myState<=3'd0;
            endcase
        end
    end

    assign out = (myState==3'd5);

endmodule