module tb (
);
    //接线
    reg [31:0]D,E,M,W;
    wire enPC,enID,enEX,enMEM,enWB;
    wire resetID,resetEX,resetMEM,resetWB;
    wire D_CMP_RsChoose,D_CMP_RtChoose,D_NPC_Rschoose;
    wire E_ALU_AChoose,E_ALU_BChoose;
    wire  M_DM_WDChoose;
    ForwardHazard uut(
        .D(D),
        .E(E),
        .M(M),
        .W(W),

        .enPC(enPC),
        .enID(enID),
        .enEX(enEX),
        .enMEM(enMEM),
        .enWB(enWB),

        .resetID(resetID),
        .resetEX(resetEX),
        .resetMEM(resetMEM),
        .resetWB(resetWB),

        .D_CMP_RsChoose(D_CMP_RsChoose), 
        .D_CMP_RtChoose(D_CMP_RtChoose),
        .D_NPC_Rschoose(D_NPC_RsChoose),

        .E_ALU_AChoose(E_ALU_AChoose),
        .E_ALU_BChoose(E_ALU_BChoose),

        .M_DM_WDChoose(M_DM_WDChoose)
    );
    //生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //初始化
    initial begin
        W=32'h3c02ffff;
        M=32'h00430820;
        E=32'h34221111;
        D=32'h10410000;
    end
    // //时钟
    // always #1 clk=~clk;
    //控制输入

endmodule



