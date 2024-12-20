`include "./mipsForwardHazard.v"
`include "./nF1_PC.v"
`include "./nF2_IM.v"
`include "./oD1_ID.v"
`include "./oD2_GRF.v"
`include "./oD3_CMP.v"
`include "./oD4_EXT.v"
`include "./oD5_NPC.v"
`include "./oD6_Controller.v"
`include "./pE1_EX.v"
`include "./pE2_ALU.v"
`include "./qM1_MEM.v"
`include "./qM2_DM.v"
`include "./rW1_WB.v"
/*输入:
`include "./n5_ALU.v"
    clk reset
    输出:无
*/
module mipsDatapath(
    input clk,reset
);
//定义线,只定义输出管脚
    //F
        // nF1_PC.v
            wire [31:0]PC_F;
        // nF2_IM.v
            wire [31:0]Ins_F;
    //D
        // oD1_ID.v
            wire [31:0] Ins_D;
            wire [31:0] PC_D;
            wire [31:0] PC4_D;
            wire [31:0] PC8_D;
        // oD2_GRF.v
            wire [31:0]GRF_RD1,GRF_RD2;
        // oD3_CMP.v
            wire CMP_isEqual;
        // oD4_EXT.v
            wire [31:0]immHasExted;
        // oD5_NPC.v
            wire [31:0]NPC;
        // oD6_Controller.v
            //GRF
            wire [1:0]GRF_1_A3_RdRtRa;
            wire      GRF_2_WE;
            //ALU
            wire      ALU_1_B;
            wire      ALU_2_EXT;
            wire [2:0]ALU_3_Op;
            //DM
            wire DM_WE;
            //NPC
            wire isJr,isBranch,isJal;
    //E
        // pE1_EX.v
            wire [31:0] Ins_E;
            wire [31:0] PC_E;
            wire [31:0] PC4_E;
            wire [31:0] PC8_E;
            //ALU操作数
            wire [31:0] Rs_E;
            wire [31:0] Rt_E;
            wire [31:0] EXT_E;
            //GRF
            wire [1:0]GRF_1_A3_RdRtRa_E;
            wire      GRF_2_WE_E;
            //ALU
            wire   ALU_1_B_E;
            wire   ALU_2_EXT_E;
            wire  [2:0]ALU_3_Op_E;
            //DM
            wire DM_WE_E;
        // pE2_ALU.v
            wire [31:0]ALU_C;
    //M
        // qM1_MEM.v
            wire [31:0] Ins_M;
            wire [31:0] PC_M;
            wire [31:0] PC4_M;
            wire [31:0] PC8_M;
            //
            wire [31:0] ALU_M;
            wire [31:0] Store_Rt_M;
            //GRF
            wire [1:0]GRF_1_A3_RdRtRa_M;
            wire      GRF_2_WE_M;
            //DM
            wire  DM_WE_M;
        // qM2_DM.v
            wire [31:0]DM_M;
    //W
        // rW1_WB.v
            wire [31:0] Ins_W;
            wire [31:0] PC_W;
            wire [31:0] PC4_W;
            wire [31:0] PC8_W;
            wire [31:0] ALU_W;
            wire [31:0] DM_W;
            //GRF
            wire [1:0]GRF_1_A3_RdRtRa_W;
            wire      GRF_2_WE_W;
    // mipsForwardHazard.v
        //PC ID EX MEM WB的暂停
        wire enPC,enID,enEX,enMEM,enWB;
        //ID EX MEM WB的清空
        wire resetID,resetEX,resetMEM,resetWB;

        //D Jr beq
        wire [1:0]D_NPC_Rschoose; //00寄存器，01ALU寄存器，10DM寄存器,11jal的PC+4
        wire [1:0]D_CMP_RsChoose; 
        wire [1:0]D_CMP_RtChoose;

        //E ALU
        wire [1:0]E_ALU_AChoose;   //00寄存器，01ALU寄存器，10DM寄存器，11jal的PC+4
        wire [1:0]E_ALU_BChoose;

        //M DM store选自己流过来的rt或者W转发来的rt
        wire [1:0]E_DM_RtChoose;   //在M输入选rt 00寄存器 01ALU 10DM 11jal的PC+4
        wire [1:0]M_DM_WDChoose;    //在M的WD选rt 00寄存器 01DM 10jal的PC+4

//连电路
    //F
        PC myPC(
            .clk(clk),
            .reset(reset),
            .en(enPC),
            
            .NPC(NPC),
            .PC(PC_F)
        );

        IM myIM(
            .PC(PC_F),
            .Ins(Ins_F)
        );

    //D
        `define rs 25:21
        `define rt 20:16
        `define rd 15:11
        ID myID(
            .clk(clk),
            .reset(reset),
            .en(enID),

            .Ins_F(Ins_F),
            .PC_F(PC_F),

            .Ins_D(Ins_D),
            .PC_D(PC_D),
            .PC4_D(PC4_D),
            .PC8_D(PC8_D)
        );

        //根据W级寄存器选择A3写入地址
        //根据W级寄存器选择A3写入数据
        wire [4:0]GRF_A3Choose;
        assign GRF_A3Choose =   (GRF_1_A3_RdRtRa_W==2'b00)?Ins_W[`rd]:
                                (GRF_1_A3_RdRtRa_W==2'b01)?Ins_W[`rt]:
                                (GRF_1_A3_RdRtRa_W==2'b10)?5'd31:
        wire [31:0]GRF_WDChoose
/*************加GRF_WD选择信号***********/
        GRF myGRF(
            .clk(clk),
            .reset(reset),

            .PC(PC_D),
            .A1(Ins_D[`rs]),
            .A2(Ins_D[`rt]),
            .A3(GRF_A3Choose),
            .GRF_WD( ),
            .GRF_WE( ),

            .RD1( ),RD2
        );

        CMP myCMP(
            .C1( ),
            .C2( ),
            .isEqual
        );

        EXT myEXT(
            .imm( ),
            .zeroOrSigned( ),

            .immHasExted
        );

        NPC myNPC(
            .PC_F( ),
            .PC_D( ),

            .rs( ),
            .imm( ),
            .ins_index( ),

            .isJr( ),
            .isBranch( ),
            .isBranchSuccess( ),
            .isJal( ),

            .NPC
        );

        Controller myController(
            .ins( ),

            .GRF_1_A3_RdRtRa( ),
            .     GRF_2_WE( ),

            .     ALU_1_B( ),
            .     ALU_2_EXT( ),
            .ALU_3_Op( ),
            
            .DM_WE( ),

            .isJr( ),isBranch( ),isJal
        );

    //E
        EX myEX(
            .clk(clk),
            .reset(reset),
            .en( ),

            .Ins_D( ),
            .PC_D( ),
            .PC4_D( ),
            .PC8_D( ),

            .Rs_D( ),
            .Rt_D( ),
            .EXT_D( ),

            .GRF_1_A3_RdRtRa_D(),
            .GRF_2_WE_D(),

            //ALU
            .  ALU_1_B_D( ),
            .  ALU_2_EXT_D( ),
            .  ALU_3_Op_D( ),
            //DM
            .DM_WE_D( ),

            .Ins_E( ),
            .PC_E( ),
            .PC4_E( ),
            .PC8_E( ),

            .Rs_E( ),
            .Rt_E( ),
            .EXT_E( ),

            .GRF_1_A3_RdRtRa_E(),
            .GRF_2_WE_E(),
            //ALU
            .  ALU_1_B_E( ),
            .  ALU_2_EXT_E( ),
            . ALU_3_Op_E( ),
            //DM
            .DM_WE_E
        );

        ALU(
            .A( ),B( ),
            .ALUOp( ),

            .C
        );

    //M
        MEM myMEM(
            .clk(clk),
            .reset(reset),
            .en( ),

            .Ins_E( ),
            .PC_E( ),
            .PC4_E( ),
            .PC8_E( ),

            .GRF_1_A3_RdRtRa_E(),
            .GRF_2_WE_E(),
            .ALU_E( ),
            .Store_Rt_E( ),

            //DM
            .DM_WE_E( ),


            .Ins_M( ),
            .PC_M( ),
            .PC4_M( ),
            .PC8_M( ),

            .GRF_1_A3_RdRtRa_M(),
            .GRF_2_WE_M(),
            .ALU_M( ),
            .Store_Rt_M( ),

            //DM
            .reg DM_WE_M
        );

        DM myDM(
            .A( ),WD( ),PC( ),
            .WE( ),

            .clk(clk),reset( ),
            
            .RD
        );

    //W
        WB myWB(
            .clk(clk),
            .reset(reset),
            .en( ),

            .Ins_M( ),
            .PC_M( ),
            .PC4_M( ),
            .PC8_M( ),

            .GRF_1_A3_RdRtRa_M(),
            .GRF_2_WE_M(),
            .ALU_M( ),
            .DM_M( ),

            .Ins_W( ),
            .PC_W( ),
            .PC4_W( ),
            .PC8_W( ),

            .GRF_1_A3_RdRtRa_W(),
            .GRF_2_WE_W(),
            .ALU_W( ),
            .DM_W
        );

    //ForwardHazard
        ForwardHazard myForwardHazard(
            .D( ),E( ),M( ),W( ),

            //PC ID EX MEM WB的暂停
            .enPC( ),enID( ),enEX( ),enMEM( ),enWB( ),
            //ID EX MEM WB的清空
            .resetID( ),resetEX( ),resetMEM( ),resetWB( ),

            //D Jr beq
            .D_NPC_Rschoose( ), //00寄存器，01ALU寄存器，10DM寄存器( ),11jal的PC+4
            .D_CMP_RsChoose( ), 
            .D_CMP_RtChoose( ),

            //E ALU
            .E_ALU_AChoose( ),   //00寄存器，01ALU寄存器，10DM寄存器，11jal的PC+4
            .E_ALU_BChoose( ),

            //M DM store选自己流过来的rt或者W转发来的rt
            .E_DM_RtChoose( ),   //在M输入选rt 00寄存器 01ALU 10DM 11jal的PC+4
            .M_DM_WDChoose    //在M的WD选rt 00寄存器 01DM 10jal的PC+4
        );
endmodule
