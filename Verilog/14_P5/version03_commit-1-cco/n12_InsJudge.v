module InsJudge(
    input [31:0]ins,
//类型判断
    output isCal_r,
    output isJReg,

    output isCal_i,
    output isBeq,
    output isLoad,
    output isStore,

    output isJal,
//寄存器
    output [4:0]Rs,
    output [4:0]Rt,
    output [4:0]Rd,
//是否读、写、写寄存器地址、是否需要ALU的Rs
    output isRead,
    output isWrite,
    output [4:0]WriteDes,
    output isNeedALURs
);
    //1.得到op和func
    wire [5:0]op,func;
    assign op   =ins[31:26];
    assign func =ins[5:0];

    //2.根据op和func判断指令
    wire R;
    wire add,sub,jr;
    wire cco;

    wire ori,lw,sw,beq,lui;

    wire jal;

    wire nop;
        //R
        assign R    = (op==6'b000000);
        assign add  = (R)&(func==6'b100_000);
        assign sub  = (R)&(func==6'b100_010);
        assign jr   = (R)&(func==6'b001_000);
        assign cco  = (R)&(func==6'b111_111);
        //I
        assign ori  = (op==6'b001_101);
        assign lw   = (op==6'b100_011);
        assign sw   = (op==6'b101_011);
        assign beq  = (op==6'b000_100);
        assign lui  = (op==6'b001_111);
        //J
        assign jal  = (op==6'b000_011);
        //nop
        assign nop  = (ins==32'h0000_0000);

    //3.把指令分成七类 R2 I4 J1
        assign isCal_r  =   (add||sub||cco)? 1:  0;
        assign isJReg   =   (jr)?   1:  0;

        assign isCal_i  =   (ori||lui)? 1:  0;
        assign isBeq    =   (beq)?  1:  0;
        assign isLoad   =   (lw)?   1:  0;
        assign isStore  =   (sw)?   1:  0;

        assign isJal    =   (jal)?  1:  0;

    //4.寄存器
        assign Rs = ins[25:21];
        assign Rt = ins[20:16];
        assign Rd = ins[15:11];
    
    //5.是否读、写、写寄存器地址、是否需要ALU的Rs
        assign isRead   =   (isCal_r||isJReg||isCal_i||isBeq||isLoad||isStore)? 1:  0;
        assign isWrite  =   (isCal_r||isCal_i||isLoad||isJal)?    1:  0;
        assign WriteDes =   (isCal_r)?          Rd:
                            (isCal_i||isLoad)?  Rt:
                            (isJal)?            5'd31:
                            5'd0;
        assign isNeedALURs  =   (isCal_r||isCal_i||isLoad||isStore)?    1:  0;
    
endmodule //InsJudge
