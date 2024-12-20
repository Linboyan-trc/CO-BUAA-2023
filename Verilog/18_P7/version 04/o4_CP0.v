module CP0(
    input               clk,
    input               reset,
    ////////// 寄存器读写 //////////
    input   [4:0]       CP0_Addr,
    input   [31:0]      CP0_Din,
    input               CP0_WE,
    output  [31:0]      CP0_DOut,
    //////////// 输入 /////////////
    input   [31:0]      PC,
    input               BD,
    input   [15:10]     HWInt,
    input   [6:2]       ExcCode,
    input               EXLClr,
    /////////// 输出 /////////////
    output  [31:0]      EPC, 
    output              Req
);

/////////////////////// 1.3个寄存器 ///////////////////////////////////////////////////
    reg     [31:0]  SR_12;  
    wire    [15:10] SR_IntMask;
    wire            SR_EXL;
    wire            SR_IntEnable;
    assign SR_IntMask   = SR_12[15:10];
    assign SR_EXL       = SR_12[1];
    assign SR_IntEnable = SR_12[0];
        ////// SR ///////////////////////////////////////////////////////////////////
        ////// {    16'b0,          
        //////      [15:10]IntMask, 8'b0,   [1]EXL, [0]IntEnable    }
    reg [31:0] Cause_13;    
        ////// Cause ////////////////////////////////////////////////////////////////
        ////// {    [31]Cause_BD,   15'b0, 
        //////      [15:10]Cause_IntPending,    3'b0,   [6:2]Cause_ExcCode, 2'b0    }    
    reg [31:0] EPC_14;     

    initial begin
        SR_12   <= 32'h0000_0000;
        Cause_13<= 32'h0000_0000;
        EPC_14  <= 32'h0000_0000;
    end

/////////////////// 2.是否响应中断或异常 ///////////////////////////////////////////////
    assign Req = (Exception | Interrupt);
    wire Exception, Interrupt;
    assign Exception = 
        (ExcCode != 5'd0) 
        & (!SR_EXL);
    assign Interrupt = 
        ( | (HWInt & SR_IntMask) ) 
        & SR_IntEnable 
        & (!SR_EXL);
    
//////////////////// 3.写入寄存器 ///////////////////////////////////////////////////
    always @(posedge clk) begin
        ///////////////////////// 1.复位 //////////////////////////////
        if (reset) begin
            SR_12   <= 32'h0000_0000;
            Cause_13<= 32'h0000_0000;
            EPC_14  <= 32'h0000_0000;
        end
        //////////////////////// 1.不复位 ////////////////////////////
        else begin
            /////////////////// 1.写外部中断信号 //////////////////////
            Cause_13[15:10] <= HWInt;
            /////////////////// 2.是否返回 ///////////////////////////
            if(EXLClr) begin
                SR_12[1] <= 1'b0;
            end
            //////////////// 3.是否响应中断，更新寄存器中的部分信号 //////
            if(Req) begin
                ////////// SR /////////
                SR_12[1]        <= 1'b1;
                ////////// Cause /////////
                Cause_13[31]    <= BD;
                Cause_13[6:2]   <= Interrupt? 5'd0 : ExcCode;
                ////////// EPC /////////
                EPC_14          <= (BD)? (PC - 32'd4) : PC;
            end
            //////////////// 4.是否写寄存器 /////////////////////////
            else if(CP0_WE) begin
                case (CP0_Addr)
                    5'd12: begin
                        SR_12 <= CP0_Din;
                    end
                    5'd14: begin
                        EPC_14 <= CP0_Din;
                    end
                    default: begin
                        /* 不操作 */
                    end
                endcase
            end
            /////////////////////////////////////////////////////
        end
    end

//////////////////// 4.输出 ///////////////////////////////////////////////////
    assign CP0_DOut =
        (CP0_Addr == 5'd12)?    SR_12:
        (CP0_Addr == 5'd13)?    Cause_13:
        (CP0_Addr == 5'd14)?    EPC_14:
                                32'd0;
    assign EPC = EPC_14;

endmodule //CP0

