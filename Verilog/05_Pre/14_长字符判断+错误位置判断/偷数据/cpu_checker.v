
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
    input [15:0]freq,
    output [1:0]format_type,
    output reg [3:0]error_code
    // output [31:0]test_pc,
    // output [15:0]test_grf,
    // output [31:0]test_addr
);
    
    reg [4:0]my_states;
    reg [2:0]cnt_up8;
    reg [1:0]cnt_up4;
    reg [7:0]my_time[3:0];
    reg [7:0]pc[7:0];
    reg [7:0]grf[3:0];//$
    reg [7:0]addr[7:0];//
    integer i;
    
    //计算time
    reg [15:0]time_cal[3:0];
    reg [15:0]time_result;
    reg [1:0]time_validPos;
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        if(time_validPos==3'd3)begin//四位数
            time_cal[0]=  {
                3'd0,my_time[0][3:0],9'd0
            }+{
                4'd0,my_time[0][3:0],8'd0
            }+{
                5'd0,my_time[0][3:0],7'd0
            }+{
                6'd0,my_time[0][3:0],6'd0
            }+{
                7'd0,my_time[0][3:0],5'd0
            }+{
                9'd0,my_time[0][3:0],3'd0
            };//相当于time[0]1000
            time_cal[1]=  {
                6'd0,my_time[1][3:0],6'd0
            }+{
                7'd0,my_time[1][3:0],5'd0
            }+{
                10'd0,my_time[1][3:0],2'd0
            };//相当于time[1]100
            time_cal[2]=  {
                8'd0,my_time[2][3:0],3'd0
            }+{
                11'd0,my_time[2][3:0],1'b0
            };//相当于time[2]10
            time_cal[3]=my_time[3];
            time_result=time_cal[0]+time_cal[1]+time_cal[2]+time_cal[3];
        end
        else if(time_validPos==3'd2)begin//三位数
            time_cal[0]=  {
                6'd0,my_time[0][3:0],6'd0
            }+{
                7'd0,my_time[0][3:0],5'd0
            }+{
                10'd0,my_time[0][3:0],2'd0
            };//相当于time[0]100
            time_cal[1]=  {
                8'd0,my_time[1][3:0],3'd0
            }+{
                11'd0,my_time[1][3:0],1'b0
            };//相当于time[1]10
            time_cal[2]=my_time[2];
            time_result=time_cal[0]+time_cal[1]+time_cal[2];            
        end
        else if(time_validPos==3'd1)begin//两位数
            time_cal[0]=  {
                8'd0,my_time[0][3:0],3'd0
            }+{
                11'd0,my_time[0][3:0],1'b0
            };//相当于time[0]10
            time_cal[1]=my_time[1];
            time_result=time_cal[0]+time_cal[1];              
        end
        else begin
            time_cal[0]=my_time[0];
            time_result=time_cal[0];
        end
    end
    // assign time_cal[0]=  {
    //         3'd0,my_time[0][3:0],9'd0
    //     }|{
    //         4'd0,my_time[0][3:0],8'd0
    //     }|{
    //         5'd0,my_time[0][3:0],7'd0
    //     }|{
    //         6'd0,my_time[0][3:0],6'd0
    //     }|{
    //         7'd0,my_time[0][3:0],5'd0
    //     }|{
    //         9'd0,my_time[0][3:0],3'd0
    //     };//相当于time[0]1000
    // assign time_cal[1]=  {
    //         6'd0,my_time[1][3:0],6'd0
    //     }|{
    //         7'd0,my_time[1][3:0],5'd0
    //     }|{
    //         10'd0,my_time[1][3:0],2'd0
    //     };//相当于time[1]100
    // assign time_cal[2]=  {
    //         8'd0,my_time[2][3:0],3'd0
    //     }|{
    //         11'd0,my_time[2][3:0],1'b0
    //     };//相当于time[2]10
    // assign time_cal[3]=my_time[3];
    // assign time_result=time_cal[0]+time_cal[1]+time_cal[2]+time_cal[3];

    integer pos01;
    integer pos02;
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        while(freq[pos01]==1'b0)begin
            pos01=pos01+1;
        end
        
        for(pos02=0;pos02<pos01-1;pos02=pos02+1)begin
            if((time_result[pos02]==1'b1)&&(format_type!=2'd0))error_code[0]=1'b1;
            if(format_type==2'd0)error_code[0]=1'b0;
        end
    end

    //计算pc
    wire [31:0]pc_result={
        pc[0][3:0],pc[1][3:0],pc[2][3:0],pc[3][3:0],pc[4][3:0],pc[5][3:0],pc[6][3:0],pc[7][3:0]
    };
    // assign test_pc=pc_result;
    wire pc_legal;
    assign pc_legal=(pc_result>=32'h00003000)&(pc_result<=32'h00004fff)&(pc_result[1:0]==2'b00);
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        if((format_type!=2'd0)&(~pc_legal))error_code[1]=(format_type!=2'd0)&(~pc_legal);
    end

    assign format_type = (my_states==`S_10)?2'b01:
                        (my_states==`S_20)?2'b10:
                        2'b00;

    //计算$后的数字为0-31
    reg [15:0]grf_cal[3:0];
    reg [15:0]grf_result;
    reg [1:0]grf_validPos;
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        if(grf_validPos==3'd3)begin//四位数
            grf_cal[0]= {
                3'd0,grf[0][3:0],9'd0
            }+{
                4'd0,grf[0][3:0],8'd0
            }+{
                5'd0,grf[0][3:0],7'd0
            }+{
                6'd0,grf[0][3:0],6'd0
            }+{
                7'd0,grf[0][3:0],5'd0
            }+{
                9'd0,grf[0][3:0],3'd0
            };//相当于time[0]1000
            grf_cal[1]=  {
                6'd0,grf[1][3:0],6'd0
            }+{
                7'd0,grf[1][3:0],5'd0
            }+{
                10'd0,grf[1][3:0],2'd0
            };//相当于time[1]100
            grf_cal[2]=  {
                8'd0,grf[2][3:0],3'd0
            }+{
                11'd0,grf[2][3:0],1'b0
            };//相当于time[2]10
            grf_cal[3]=grf[3];
            grf_result=grf_cal[0]+grf_cal[1]+grf_cal[2]+grf_cal[3];
        end
        else if(grf_validPos==3'd2)begin//三位数
            grf_cal[0]=  {
                6'd0,grf[0][3:0],6'd0
            }+{
                7'd0,grf[0][3:0],5'd0
            }+{
                10'd0,grf[0][3:0],2'd0
            };//相当于time[1]100
            grf_cal[1]=  {
                8'd0,grf[1][3:0],3'd0
            }+{
                11'd0,grf[1][3:0],1'b0
            };//相当于time[2]10
            grf_cal[2]=grf[2];
            grf_result=grf_cal[0]+grf_cal[1]+grf_cal[2];
        end
        else if(grf_validPos==3'd1)begin//两位数
            grf_cal[0]=  {
                8'd0,grf[0][3:0],3'd0
            }+{
                11'd0,grf[0][3:0],1'b0
            };//相当于grf[1]10
            grf_cal[1]=grf[1];
            grf_result=grf_cal[0]+grf_cal[1];
        end
        else begin
            grf_cal[0]=grf[0];
            grf_result=grf_cal[0];
        end
    end
    // assign grf_cal[0]=  {
    //         3'd0,grf[0][3:0],9'd0
    //     }|{
    //         4'd0,grf[0][3:0],8'd0
    //     }|{
    //         5'd0,grf[0][3:0],7'd0
    //     }|{
    //         6'd0,grf[0][3:0],6'd0
    //     }|{
    //         7'd0,grf[0][3:0],5'd0
    //     }|{
    //         9'd0,grf[0][3:0],3'd0
    //     };//相当于grf[0]1000
    // assign grf_cal[1]=  {
    //         6'd0,grf[1][3:0],6'd0
    //     }|{
    //         7'd0,grf[1][3:0],5'd0
    //     }|{
    //         10'd0,grf[1][3:0],2'd0
    //     };//相当于grf[1]100
    // assign grf_cal[2]=  {
    //         8'd0,grf[2][3:0],3'd0
    //     }|{
    //         11'd0,grf[2][3:0],1'b0
    //     };//相当于grf[2]10
    // assign grf_cal[3]=grf[3];
    // assign grf_result=grf_cal[0]+grf_cal[1]+grf_cal[2]+grf_cal[3];
    // assign test_grf=grf_result;
    wire grf_legal;
    assign grf_legal=(grf_result>=0)&(grf_result<=31);
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        if((format_type==2'd1)&(~grf_legal))error_code=grf_result[7:4];
    end

    //计算后的addr
    wire [31:0]addr_result={
        addr[0][3:0],addr[1][3:0],addr[2][3:0],addr[3][3:0],addr[4][3:0],addr[5][3:0],addr[6][3:0],addr[7][3:0]
    };
    // assign test_addr=addr_result;
    wire addr_legal;
    assign addr_legal=(addr_result>=32'h00000000)&(addr_result<=32'h00002fff)&(addr_result[1:0]==2'b00);
    always @(clk,format_type,my_time[0],pc[0],grf[0],addr[0],char,error_code,my_states,cnt_up4,cnt_up8) begin
    // always @(multi) begin
        if((format_type==2'd2)&(~addr_legal))error_code[2]=(format_type==2'd2)&(~addr_legal);
    end

    assign format_type = (my_states==`S_10)?2'b01:
                        (my_states==`S_20)?2'b10:
                        2'b00;


    always @(posedge clk) begin
        if(reset)begin
            my_states<=`S_00;
            cnt_up8<=3'd0;
            cnt_up4<=2'd0;
            for(i=0;i<4;i=i+1)begin
                my_time[i]<=8'd0;
                grf[i]<=8'd0;
            end
            for(i=0;i<8;i=i+1)begin
                pc[i]<=8'd0;
                addr[i]<=8'd0;
            end
            error_code<=4'd0;
            pos01<=32'd0;
            pos02<=32'd0;
            time_validPos<=2'd0;
            grf_validPos<=2'd0;
        end
        else begin
            case (my_states)
                `S_00: begin
                    my_states<=(char=="^")?`S_01:
                                `S_00;
                    cnt_up8<=3'd0;
                    cnt_up4<=2'd0;
                    for(i=0;i<4;i=i+1)begin
                        my_time[i]<=8'd0;
                        grf[i]<=8'd0;
                    end
                    for(i=0;i<8;i=i+1)begin
                        pc[i]<=8'd0;
                        addr[i]<=8'd0;
            end
                end
                `S_01:begin
                    if(char>="0"&&char<="9")begin
                        my_states<=`S_02;
                        cnt_up4<=2'd1;
                        my_time[cnt_up4]<=char-"0";
                    end
                    else begin
                        my_states<=(char=="^")?`S_01:
                                `S_00;
                    end
                end
                `S_02:begin
                    if(char>="0"&&char<="9")begin
                        cnt_up4<=cnt_up4+2'd1;
                        time_validPos<=cnt_up4;
                        my_time[cnt_up4]<=char-"0";
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
                        if((char>="0")&&(char<="9"))begin
                            pc[cnt_up8]<=char-"0";
                        end
                        else begin
                            pc[cnt_up8]<=char-"a"+10;
                        end
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
                        if((char>="0")&&(char<="9"))begin
                            pc[cnt_up8]<=char-"0";
                            end
                        else begin
                            pc[cnt_up8]<=char-"a"+10;
                            end
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
                                (char==8'd42)?`S_29:
                                (char=="^")?`S_01:
                                `S_00;
                end
                `S_27:begin
                    if(char>="0"&&char<="9")begin
                        cnt_up4<=2'd1;
                        grf[cnt_up4]<=char-"0";
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
                        grf_validPos<=cnt_up4;
                        grf[cnt_up4]<=char-"0";
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
                        if((char>="0")&&(char<="9"))begin
                            addr[cnt_up8]<=char-"0";
                            end
                        else begin
                            addr[cnt_up8]<=char-"a"+10;
                        end
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
                        if((char>="0")&&(char<="9"))begin
                            addr[cnt_up8]<=char-"0";
                            end
                        else begin
                            addr[cnt_up8]<=char-"a"+10;
                        end
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