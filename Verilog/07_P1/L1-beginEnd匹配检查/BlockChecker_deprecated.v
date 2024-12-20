module BlockChecker (
    input clk,reset,
    input [7:0]in,
    output result
);
    reg my_state,beginFlag,endFlag;
    reg [7:0]beginRec[5:0];
    reg [2:0]iBR;
    reg [7:0]endRec[3:0];
    reg [2:0]iER;
    reg [7:0]wordRec[5:0];
    reg [2:0]iWR;
    initial begin
        my_state<=1'd0;
        beginFlag<=1'd0;
        endFlag<=1'd0;
        beginRec[0]<=8'd0;
        beginRec[1]<=8'd0;
        beginRec[2]<=8'd0;
        beginRec[3]<=8'd0;
        beginRec[4]<=8'd0;
        iBR<=3'd0;
        endRec[0]<=8'd0;
        endRec[1]<=8'd0;
        endRec[2]<=8'd0;
        endRec[3]<=8'd0;
        iER<=3'd0;
        wordRec[0]<=8'd0;
        wordRec[1]<=8'd0;
        wordRec[2]<=8'd0;
        wordRec[3]<=8'd0;
        wordRec[4]<=8'd0;
        wordRec[5]<=8'd0;
        iWR<=3'd0;
    end
    //状态转移
    always @(posedge clk,clr) begin
        if(clr)begin
            my_state<=1'd0;
            beginFlag<=1'd0;
            endFlag<=1'd0;
            beginRec[0]<=8'd0;
            beginRec[1]<=8'd0;
            beginRec[2]<=8'd0;
            beginRec[3]<=8'd0;
            beginRec[4]<=8'd0;
            iBR<=3'd0;
            endRec[0]<=8'd0;
            endRec[1]<=8'd0;
            endRec[2]<=8'd0;
            endRec[3]<=8'd0;
            iER<=3'd0;
            wordRec[0]<=8'd0;
            wordRec[1]<=8'd0;
            wordRec[2]<=8'd0;
            wordRec[3]<=8'd0;
            wordRec[4]<=8'd0;
            wordRec[5]<=8'd0;
            iWR<=3'd0;
        end
        else if(clk)begin
            case (my_state)
                1'd0: begin
                    if(((in>="a")&&(in<="z"))||((in>="A")&&(in<="Z")))begin
                        my_state<=1'd1;
                        wordRec[5-iWR]<=in;
                        iWR<=1;
                    end
                    else if(in==" ")begin
                        my_state<=1'd0;
                    end
                    else begin
                        my_state<=1'd0;
                    end
                end
                1'd1: begin
                    if(((in>="a")&&(in<="z"))||((in>="A")&&(in<="Z")))begin
                        my_state<=1'd1;
                        if(iWR<=5)begin
                            wordRec[4-iWR]<=in;
                            iWR<=iWR+1;
                        end
                    end
                    else if(in==" ")begin
                        my_state<=1'd0;
                        wordRec[0]<=8'd0;
                        wordRec[1]<=8'd0;
                        wordRec[2]<=8'd0;
                        wordRec[3]<=8'd0;
                        wordRec[4]<=8'd0;
                        wordRec[5]<=8'd0;
                        iWR<=3'd0;
                    end
                    else begin
                        my_state<=1'd0;
                    end
                end
            endcase
        end
    end
    //米粒机，输入+当前状态=输出
    assign beginFlag = (wordRec[5]=="b"|wordRec[5]=="B")
                    &(wordRec[4]=="e"|wordRec[4]=="E")
                    &(wordRec[3]=="g"|wordRec[3]=="G")
                    &(wordRec[2]=="i"|wordRec[2]=="I")
                    &(wordRec[1]=="n"|wordRec[1]=="N")
                    &(wordRec[0]==8'd0|wordRec[0]==8'd0)?1:
                    0;
    assign endFlag = (wordRec[5]=="e"|wordRec[5]=="E")
                    &(wordRec[4]=="n"|wordRec[4]=="N")
                    &(wordRec[3]=="d"|wordRec[3]=="D")
                    &(wordRec[2]==8'd0|wordRec[2]==8'd0)?1:
                    0;
    assign result =                     
endmodule