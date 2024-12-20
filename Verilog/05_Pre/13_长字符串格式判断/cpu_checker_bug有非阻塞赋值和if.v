//状态,每个状态含义在草稿纸上
`define S_00 8'd0
`define S_01 8'd1
`define S_02 8'd2
`define S_03 8'd3
`define S_04 8'd4
`define S_05 8'd5
`define S_16 8'd16
`define S_17 8'd17
`define S_18 8'd18
`define S_19 8'd19
`define S_20 8'd20
`define S_21 8'd21
`define S_22 8'd22
`define S_23 8'd23
`define S_24 8'd24
`define S_25 8'd25
`define S_26 8'd26
`define S_27 8'd27
`define S_28 8'd28
`define S_29 8'd29
`define S_30 8'd30
`define S_31 8'd31
`define S_32 8'd32
`define S_33 8'd33
`define S_34 8'd34
`define S_35 8'd35
`define S_36 8'd36

module cpu_checker (
    input clk,
    input reset,
    input [7:0]char,
    output [1:0]format_type
);
//寄存状态
    reg [7:0]my_states;
    reg [3:0]cnt_01,cnt_02,cnt_03,cnt_04,cnt_05,cnt_06;  //01用于十进制数时间，02用于十六进制数pc地址，03用于十进制寄存器，04用于十六进制数据
                                                                        //  05用于十六进制地址，06用于十六进制数据
//初始化
    //为了保证可综合，初始化在always块中用reset实现；reset由tb输入
    always @(posedge clk) begin
        if(reset) begin
            my_states<=`S_00;
            cnt_01<=0;
            cnt_02<=0;
            cnt_03<=0;
            cnt_04<=0;
            cnt_05<=0;
            cnt_06<=0;
        end
        else begin
            case (my_states)
                `S_00: begin
                    my_states<= (char=="^")?`S_01:
                                `S_00;
                end
                `S_01: begin
                    //数字跳状态2，否则可能回0或者回1
                    if ((char>="0")&&(char<="9")) begin
                        my_states<=`S_02;
                        cnt_01<=1;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_02: begin
                    //十进2-4保持，@跳状态3，否则可能回0或者回1
                    if (((char>="0")&&(char<="9"))&&(cnt_01<=4)) begin
                        cnt_01<=cnt_01+1;
                        if(cnt_01<=4)my_states<=`S_02;
                        else my_states<=`S_00;
                    end
                    else if ((char=="@")&&(cnt_01<=4))begin
                        cnt_02<=0;//即将输入pc地址，cnt_02初始化
                        my_states<=`S_03;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_03: begin
                    //十六进1-8保持，十六进制8且:跳状态5，否则可能回0或者回1
                    if ((((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))&&(cnt_02<=8)) begin
                        cnt_02<=cnt_02+1;
                        if(cnt_02<=8)my_states<=`S_03;
                        else my_states<=`S_00;
                    end
                    else if ((char==":")&&(cnt_02==8))begin
                        my_states<=`S_05;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_05: begin
                    //空格保持，$跳状态16,十进制03启动，*跳状态26十六进制05启动，否则可能回0或者回1
                    if (char==" ") begin
                        my_states<=`S_05;
                    end
                    else if (char=="$")begin
                        my_states<=`S_16;
                        cnt_03<=0;
                    end
                    else if (char=="*")begin
                        my_states<=`S_26;
                        cnt_05<=0;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_16: begin
                    //十进制1-4保持，空格跳18，<跳19，否则可能回0或者回1
                    if (((char>="0")&&(char<="9"))&&(cnt_03<=4)) begin
                        cnt_03<=cnt_03+1;
                        if(cnt_03<=4)my_states<=`S_16;
                        else my_states<=`S_00;
                    end
                    else if ((char==" ")&&(cnt_03<=4))begin
                        my_states<=`S_18;
                    end
                    else if ((char=="<")&&(cnt_03<=4))begin
                        my_states<=`S_19;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_18: begin
                    //空格保持，<跳19，否则可能回0或者回1
                    if (char==" ")begin
                        my_states<=`S_18;
                    end
                    else if (char=="<")begin
                        my_states<=`S_19;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_19: begin
                    //=跳20并启用十六进制计数器04，否则可能回0或者回1
                    if (char=="=")begin
                        my_states<=`S_20;
                        cnt_04<=0;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_20: begin
                    //空格保持，十六进制1跳21，否则可能回0或者回1
                    if (char==" ")begin
                        my_states<=`S_20;
                    end
                    else if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_04<=1;
                        my_states<=`S_21;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_21: begin
                    //十六进制2-8保持，十六进制8且#跳23，否则可能回0或者回1
                    if ((((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))&&(cnt_04<=8))begin
                        cnt_04<=cnt_04+1;
                        if(cnt_04<=8)my_states<=`S_21;
                        else my_states<=`S_00;
                    end
                    else if((char=="#")&&(cnt_04==8))begin
                        my_states<=`S_23;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_23: begin
                    //可能回0或者回1
                    my_states<= (char=="^")?`S_01:
                                `S_00;
                end
                `S_26: begin
                    //十六进制1-7保持，十六进制8跳27，超过回0，否则可能回0或者回1
                    if ((((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))&&(cnt_05<=7))begin
                        cnt_05<=cnt_05+1;
                        if(cnt_05<=6)my_states<=`S_26;
                        else if(cnt_05==7)my_states<=`S_27;
                        else my_states<=`S_00;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end                   
                end
                `S_27: begin
                    //空格保持，<跳28，否则可能回0或者回1
                    if (char==" ")begin
                        my_states<=`S_27;
                    end
                    else if(char=="<") my_states<=`S_28;
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end                   
                end
                `S_28: begin
                    //=跳29，否则可能回0或者回1
                    if (char=="=")begin
                        my_states<=`S_29;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end                   
                end
                `S_29: begin
                    //空格保持，十六进制1跳30并启用计数器06，否则可能回0或者回1
                    if (char==" ")begin
                        my_states<=`S_29;
                    end
                    else if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_06<=1;
                        my_states<=`S_30;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end                   
                end
                `S_30: begin
                    //十六进制2-8保持，十六进制8且#跳31，否则可能回0或者回1
                    if ((((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))&&(cnt_06<=7))begin
                        cnt_06<=cnt_06+1;
                        if(cnt_06<=7)my_states<=`S_30;
                        else my_states<=`S_00;
                    end
                    else if((char=="#")&&(cnt_06==8))begin
                        my_states<=`S_31;
                    end
                    else begin
                        my_states<= (char=="^")?`S_01:
                                    `S_00;
                    end                   
                end
                `S_31: begin
                    my_states<= (char=="^")?`S_01:
                                `S_00;                  
                end
            endcase
        end
    end
//判断输出
    assign format_type= (my_states==`S_23)?2'b01:
                        (my_states==`S_31)?2'b10:
                        2'b00;
endmodule
