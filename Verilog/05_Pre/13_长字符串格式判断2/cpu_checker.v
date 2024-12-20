`define S_00 5'd0
`define S_01 5'd1
`define S_02 5'd2
`define S_03 5'd3
`define S_04 5'd4
`define S_05 5'd5
`define S_06 5'd6
`define S_07 5'd7
`define S_08 5'd8
`define S_09 5'd9
`define S_10 5'd10
`define S_11 5'd11
`define S_12 5'd12
`define S_13 5'd13
`define S_14 5'd14
`define S_15 5'd15
`define S_16 5'd16
`define S_17 5'd17
`define S_18 5'd18
`define S_19 5'd19
`define S_20 5'd20
`define S_25 5'd25
`define S_27 5'd27
`define S_29 5'd29

module cpu_checker (
    input clk,
    input reset,
    input [7:0]char,
    output [1:0]format_type
);
    
    reg [4:0]my_states;
    reg [2:0]cnt_up8;
    reg [1:0]cnt_up4;

    assign format_type = (my_states==`S_10)?2'b01:
                        (my_states==`S_20)?2'b10:
                        2'b00;

    always @(posedge clk) begin
        if(reset)begin
            my_states<=`S_00;
            cnt_up8<=3'd0;
            cnt_up4<=2'd0;
        end
        else begin
            case (my_states)
                `S_00: begin
                    my_states<=(char=="^")?`S_01:
                                `S_00;
                end
                `S_01:begin
                    if(char>="0"&&char<="9")begin
                        my_states<=`S_02;
                        cnt_up4<=2'd1;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_02:begin
                    if(char>="0"&&char<="9")begin
                        cnt_up4<=cnt_up4+2'd1;
                        if(cnt_up4==2'd0)my_states<=`S_00;
                        else my_states<=`S_02;
                    end
                    else if(char=="@")begin
                        my_states<=`S_25;
                        cnt_up4<=2'd0;
                        cnt_up8<=3'd0;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_25:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=3'd1;
                        my_states<=`S_03;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_03:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=cnt_up8+3'd1;
                        if(cnt_up8==3'd0)my_states<=`S_00;
                        else my_states<=`S_03;
                    end
                    else if((char==":")&&(cnt_up8==3'd0))begin
                        my_states<=`S_04;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_04:begin
                    my_states<= (char==" ")?`S_04:
                                (char=="$")?`S_27:
                                (char=="*")?`S_29:
                                (char=="^")?`S_01:
                                `S_00;
                end
                `S_27:begin
                    if(char>="0"&&char<="9")begin
                        cnt_up4<=2'd1;
                        my_states<=`S_05;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                    `S_00;
                    end
                end
                `S_05:begin
                    if(char>="0"&&char<="9")begin
                        cnt_up4<=cnt_up4+2'd1;
                        if(cnt_up4==2'd0)my_states<=`S_00;
                        else my_states<=`S_05;
                    end
                    else if(char==" ")begin
                        my_states<=`S_06;
                        cnt_up4<=2'd0;
                        cnt_up8<=3'd0;
                    end
                    else if(char=="<")begin
                        my_states<=`S_07;
                        cnt_up4<=2'd0;
                        cnt_up8<=3'd0;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_06:begin
                    if(char==" ")begin
                        my_states<=`S_06;
                    end
                    else if(char=="<")begin
                        my_states<=`S_07;
                    end
                    else begin
                         my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_07:begin
                    if(char=="=")begin
                        my_states<=`S_08;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_08:begin
                    if(char==" ")begin
                        my_states<=`S_08;
                    end
                    else if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        my_states<=`S_09;
                        cnt_up8<=3'd1;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_09:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=cnt_up8+3'd1;
                        if(cnt_up8==3'd0)my_states<=`S_00;
                        else my_states<=`S_09;
                    end
                    else if((char=="#")&&(cnt_up8==3'd0))begin
                        my_states<=`S_10;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_10:begin
                    my_states<=(char=="^")?`S_01:
                                `S_00;
                end
                `S_29:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=3'd1;
                        my_states<=`S_15;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_15:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=cnt_up8+3'd1;
                        if(cnt_up8==3'd0)my_states<=`S_00;
                        else my_states<=`S_15;
                    end
                    else if((char==" ")&&(cnt_up8==3'd0))begin
                        my_states<=`S_16;
                    end
                    else if((char=="<")&&(cnt_up8==3'd0))begin
                        my_states<=`S_17;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_16:begin
                    my_states<= (char==" ")?`S_16:
                                (char=="<")?`S_17:
                                (char=="^")?`S_01:
                                `S_00;
                end
                `S_17:begin
                    my_states<= (char=="=")?`S_18:
                                (char=="^")?`S_01:
                                `S_00;
                end
                `S_18:begin
                    if(char==" ")begin
                        my_states<=`S_18;
                    end
                    else if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=3'd1;
                        my_states<=`S_19;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_19:begin
                    if(((char>="0")&&(char<="9"))||((char>="a")&&(char<="f")))begin
                        cnt_up8<=cnt_up8+3'd1;
                        if(cnt_up8==3'd0)my_states<=`S_00;
                        else my_states<=`S_19;
                    end
                    else if((char=="#")&&(cnt_up8==3'd0))begin
                        my_states<=`S_20;
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_20:begin
                     my_states<=(char=="^")?`S_01:
                                `S_00;
                end
                default: my_states<=`S_00;
            endcase
        end
    end

endmodule