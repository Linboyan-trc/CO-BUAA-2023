// `include "./n3_NPC.v"
// `include "./n2_PC.v"
// `include "./n8_Controller.v"
// `include "./n4_GRF.v"
// `include "./n6_DM.v"
// `include "./n1_IM.v"
// `include "./n7_EXT.v"
/*输入:
`include "./n5_ALU.v"
    clk reset
    输出:无
*/
module mipsDatapath(
    input clk,reset
);
//1.输出线路声明**************************************************************************************************************************************
    //F
        //PC
            wire [31:0] PC_F;
        //IM
            wire [31:0] INS_F;
    //D
        //ID
            //INS,PC,PC4*******************
            wire [31:0]    INS_D;
            wire [31:0]    PC_D;
            wire [31:0]    PC4_D;
            //RD1,RD2**********************
            //wire [31:0]    RD1_D;
            //wire [31:0]    RD2_D;
            //isStandbySuc*****************
            //wire           isStandbySuc_D;
            //PC8,ALU,DM*******************
            wire [31:0]    PC8_D;
            //wire [31:0]    ALU_D;
            //wire [31:0]    DM_D;
            //standby**********************
            //wire [31:0]    standby_D;
        //Controller_D
            //GRF**********************************
            //wire [1:0]    GRF_A3_01,
            //wire          GRF_WE_02,
            //ALU**********************************
            // wire          ALU_B_01,
            // wire          ALU_immExt_02,
            // wire [2:0]    ALU_Op_03,
            //DM***********************************
            // wire          DM_WE_01,
            //NPC**********************************
            wire          NPC_isJr_01;
            wire          NPC_isJ_02;
            wire          NPC_isBeq_03;
            //ins_parts****************************
            wire [4:0]    Rs_D;
            wire [4:0]    Rt_D;
            wire [4:0]    Rd_D;
            wire [15:0]   imm_D;
            wire [25:0]   ins_index_D;
            //暂停转发******************************
            //1.送出选择
            // wire [1:0]    Forward_outChoose_D;
            //2.Tuse_Rs Tuse_Rt Tnew
            wire [1:0]    Tuse_Rs_D;
            wire [1:0]    Tuse_Rt_D;
            wire [1:0]    Tnew_D;
            //3.是否读写
            wire          isRead_Rs_D;
            wire          isRead_Rt_D;
            wire          isWrite_D;
            wire [4:0]    WriteDes_D;
        //GRF
            wire [31:0]   RD1_D;
            wire [31:0]   RD2_D;
        //NPC
            wire [31:0]   NPC;
        //CMP
            wire          isEqual_CMP;
    //E
        //EX
            //INS,PC,PC4*******************
            wire [31:0]    INS_E;
            wire [31:0]    PC_E;
            wire [31:0]    PC4_E;
            //RD1,RD2**********************
            wire [31:0]    RD1_E;
            wire [31:0]    RD2_E;
            //isStandbySuc*****************
            wire           isStandbySuc_E;
            //PC8,ALU,DM*******************
            wire [31:0]    PC8_E;
            //wire [31:0]    ALU_E;
            //wire [31:0]    DM_E;
            //standby**********************
            wire [31:0]    standby_E;
        //Controller_E
            //GRF**********************************
            // wire [1:0]    GRF_A3_01,
            // wire          GRF_WE_02,
            //ALU**********************************
            wire          ALU_B_01;
            wire          ALU_immExt_02;
            wire [2:0]    ALU_Op_03;
            //DM***********************************
            // wire          DM_WE_01,
            //NPC**********************************
            // wire          NPC_isJr_01,
            // wire          NPC_isJ_02,
            // wire          NPC_isBeq_03,
            //ins_parts****************************
            wire [4:0]    Rs_E;
            wire [4:0]    Rt_E;
            wire [4:0]    Rd_E;
            wire [15:0]   imm_E;
            wire [25:0]   ins_index_E;
            //暂停转发******************************
            //1.送出选择
            wire [1:0]    Forward_outChoose_E;
            //2.Tuse_Rs Tuse_Rt Tnew
            wire [1:0]    Tuse_Rs_E;
            wire [1:0]    Tuse_Rt_E;
            wire [1:0]    Tnew_E;
            //3.是否读写
            wire          isRead_Rs_E;
            wire          isRead_Rt_E;
            wire          isWrite_E;
            wire [4:0]    WriteDes_E;
        //ALU
            wire [31:0]   ALU_E;
        //EXT
            wire [31:0]   imm_HasExted_E;
    //M
        //MEM  
            //INS,PC,PC4*******************
            wire [31:0]    INS_M;
            wire [31:0]    PC_M;
            wire [31:0]    PC4_M;
            //RD1,RD2**********************
            wire [31:0]    RD1_M;
            wire [31:0]    RD2_M;
            //isStandbySuc*****************
            wire           isStandbySuc_M;
            //PC8,ALU,DM*******************
            wire [31:0]    PC8_M;
            wire [31:0]    ALU_M;
            //wire [31:0]    DM_M;
            //standby**********************
            wire [31:0]    standby_M;
        //Controller_M
            //GRF**********************************
            // wire [1:0]    GRF_A3_01,
            // wire          GRF_WE_02,
            //ALU**********************************
            // wire          ALU_B_01,
            // wire          ALU_immExt_02,
            // wire [2:0]    ALU_Op_03,
            //DM***********************************
            wire          DM_WE_01;
            //NPC**********************************
            // wire          NPC_isJr_01,
            // wire          NPC_isJ_02,
            // wire          NPC_isBeq_03,
            //ins_parts****************************
            wire [4:0]    Rs_M;
            wire [4:0]    Rt_M;
            wire [4:0]    Rd_M;
            wire [15:0]   imm_M;
            wire [25:0]   ins_index_M;
            //暂停转发******************************
            //1.送出选择
            wire [1:0]    Forward_outChoose_M;
            //2.Tuse_Rs Tuse_Rt Tnew
            wire [1:0]    Tuse_Rs_M;
            wire [1:0]    Tuse_Rt_M;
            wire [1:0]    Tnew_M;
            //3.是否读写
            wire          isRead_Rs_M;
            wire          isRead_Rt_M;
            wire          isWrite_M;
            wire [4:0]    WriteDes_M;
        //DM
            wire [31:0]   DM_M;
    //W
        //WB
            //INS,PC,PC4*******************
            wire [31:0]    INS_W;
            wire [31:0]    PC_W;
            wire [31:0]    PC4_W;
            //RD1,RD2**********************
            wire [31:0]    RD1_W;
            wire [31:0]    RD2_W;
            //isStandbySuc*****************
            wire           isStandbySuc_W;
            //PC8,ALU,DM*******************
            wire [31:0]    PC8_W;
            wire [31:0]    ALU_W;
            wire [31:0]    DM_W;
            //standby**********************
            wire [31:0]    standby_W;
        //Controller_W
            //GRF**********************************
            wire [1:0]    GRF_A3_01;
            wire          GRF_WE_02;
            //ALU**********************************
            // wire          ALU_B_01,
            // wire          ALU_immExt_02,
            // wire [2:0]    ALU_Op_03,
            //DM***********************************
            // wire          DM_WE_01,
            //NPC**********************************
            // wire          NPC_isJr_01,
            // wire          NPC_isJ_02,
            // wire          NPC_isBeq_03,
            //ins_parts****************************
            wire [4:0]    Rs_W;
            wire [4:0]    Rt_W;
            wire [4:0]    Rd_W;
            wire [15:0]   imm_W;
            wire [25:0]   ins_index_W;
            //暂停转发******************************
            //1.送出选择
            wire [1:0]    Forward_outChoose_W;
            //2.Tuse_Rs Tuse_Rt Tnew
            wire [1:0]    Tuse_Rs_W;
            wire [1:0]    Tuse_Rt_W;
            wire [1:0]    Tnew_W;
            //3.是否读写
            wire          isRead_Rs_W;
            wire          isRead_Rt_W;
            wire          isWrite_W;
            wire [4:0]    WriteDes_W;
    //Hazard
            wire stallPC,stallID,flushEX;
            //使能线路声明*********************
            wire enEX,enMEM,enWB;
            assign enEX = 1'b1;
            assign enMEM = 1'b1;
            assign enWB = 1'b1;
    //Forward
        //D <- E M
            //Rs
            wire isNeedForward_Rs_DE;
            wire isNeedForward_Rs_DEM;
            //Rt
            wire isNeedForward_Rt_DE;
            wire isNeedForward_Rt_DEM;
        //E <- M W
            //Rs
            wire isNeedForward_Rs_EM;
            wire isNeedForward_Rs_EMW;
            //Rt
            wire isNeedForward_Rt_EM;
            wire isNeedForward_Rt_EMW;
        //M <- W
            //Rs
            wire isNeedForward_Rs_MW;
            //Rt
            wire isNeedForward_Rt_MW;

//2.模块连线*****************************************************************************************************************************************
    //F
        //PC
        PC  myPC (
            .clk(clk),
            .reset(reset),
            .en(~stallPC),

            .NPC(NPC),

            .PC(PC_F)
        );
        //IM
        IM myIM (
            .PC(PC_F),
            .Ins(INS_F)
        );
    //D
        //ID
        DEMW myID (
        //三件套
            .clk(clk),
            .reset(reset),
            .en(~stallID),
        //INS( ),PC( ),PC4*******************
            .INS( INS_F),
            .PC(PC_F),
            .PC4(PC_F+32'd4),
        //RD1( ),RD2**********************
            // .RD1(RD1_F),
            // .RD2(RD2_F),
        //isStandbySuc*****************
            // .isStandbySuc(isStandbySuc_F_final),
        //PC8( ),ALU( ),DM*******************
            .PC8(PC_F+32'd8),
            // .ALU(ALU_F),
            // .DM(DM_F),
        //standby**********************
            // .standby(standby_F),


        //INS( ),PC( ),PC4*******************
            .INS_final(INS_D),
            .PC_final(PC_D),
            .PC4_final(PC4_D),
        //RD1( ),RD2**********************
            // .RD1_final(RD1_D),
            // .RD2_final(RD2_D),
        //isStandbySuc*****************
            // .isStandbySuc_final(isStandbySuc_D),
        //PC8( ),ALU( ),DM*******************
            .PC8_final(PC8_D)
            // .ALU_final(ALU_D),
            // .DM_final(DM_D),
        //standby**********************
            // .standby_final(standby_D)
        );
        //Controller_D
        wire [2:0]  stage_D=3'd1;
        Controller myController_D (
            //输入**********************************
                .ins(INS_D),
                .stage(stage_D),
                //.isSuc(standbySuc_D),
            //GRF**********************************
                // .GRF_A3_01(GRF_A3_01),
                // .GRF_WE_02(GRF_WE_02),
            //ALU**********************************
                // .ALU_B_01(ALU_B_01),
                // .ALU_immExt_02(ALU_immExt_02),
                // .ALU_Op_03(ALU_Op_03),
            //DM***********************************
                // .DM_WE_01(DM_WE_01),
            //NPC**********************************
                .NPC_isJr_01(NPC_isJr_01),
                .NPC_isJ_02(NPC_isJ_02),
                .NPC_isBeq_03(NPC_isBeq_03),
            //ins_parts****************************
                .Rs(Rs_D),
                .Rt(Rt_D),
                .Rd(Rd_D),
                .imm(imm_D),
                .ins_index(ins_index_D),
            //暂停转发******************************
                //1.送出选择
                //.Forward_outChoose(Forward_outChoose_D),
                //2.Tuse_Rs Tuse_Rt Tnew
                .Tuse_Rs(Tuse_Rs_D),
                .Tuse_Rt(Tuse_Rt_D),
                .Tnew(Tnew_D),
                //3.是否读写
                .isRead_Rs(isRead_Rs_D),
                .isRead_Rt(isRead_Rt_D),
                .isWrite(isWrite_D),
                .WriteDes(WriteDes_D)
        );
        //GRF
            //选择A3端口
            wire [4:0] tempA3;
            assign tempA3 = 
                (GRF_A3_01==2'b10)? 5'd31:
                (GRF_A3_01==2'b01)? Rt_W:
                                    Rd_W;
            GRF  myGRF (
                .clk(clk),
                .reset(reset),

                .PC_W(PC_W),
                .A1(Rs_D),
                .A2(Rt_D),
                .A3(tempA3),
                .WD(Data_W),
                .WE(GRF_WE_02),

                .RD1(RD1_D),
                .RD2(RD2_D)
            );
        //NPC
        NPC  myNPC (
            .PC_F(PC_F),
            .PC_D(PC_D),

            .rs(RD1_D_final),
            .imm(imm_D),
            .ins_index(ins_index_D),

            .isJr(NPC_isJr_01),
            .isJ(NPC_isJ_02),
            .isBranchSuccess(NPC_isBeq_03 & isEqual_CMP),

            .NPC(NPC)
        );
        //CMP
        CMP myCMP (
            .Rs(RD1_D_final),
            .Rt(RD2_D_final),

            .isEqual(isEqual_CMP)
        );
    //E
        //EX
        DEMW myEX (
        //三件套
            .clk(clk),
            .reset(reset|flushEX),
            .en(enEX),
        //INS( ),PC( ),PC4*******************
            .INS( INS_D),
            .PC(PC_D),
            .PC4(PC4_D),
        //RD1( ),RD2**********************
            .RD1(RD1_D_final),
            .RD2(RD2_D_final),
        //isStandbySuc*****************
            .isStandbySuc(isStanbydSuc_D_final),
        //PC8( ),ALU( ),DM*******************
            .PC8(PC8_D),
            // .ALU(ALU_D),
            // .DM(DM_D),
        //standby**********************
            .standby(standby_D_final),


        //INS( ),PC( ),PC4*******************
            .INS_final(INS_E),
            .PC_final(PC_E),
            .PC4_final(PC4_E),
        //RD1( ),RD2**********************
            .RD1_final(RD1_E),
            .RD2_final(RD2_E),
        //isStandbySuc*****************
            .isStandbySuc_final(isStandbySuc_E),
        //PC8( ),ALU( ),DM*******************
            .PC8_final(PC8_E),
            // .ALU_final(ALU_E),
            // .DM_final(DM_E),
        //standby**********************
            .standby_final(standby_E)
        );
        //Controller_E
            wire [2:0]  stage_E=3'd2;
            Controller myController_E (
            //输入**********************************
                .ins(INS_E),
                .stage(stage_E),
                .isSuc(standbySuc_E),
            //GRF**********************************
                // .GRF_A3_01(GRF_A3_01),
                // .GRF_WE_02(GRF_WE_02),
            //ALU**********************************
                .ALU_B_01(ALU_B_01),
                .ALU_immExt_02(ALU_immExt_02),
                .ALU_Op_03(ALU_Op_03),
            //DM***********************************
                // .DM_WE_01(DM_WE_01),
            //NPC**********************************
                // .NPC_isJr_01(NPC_isJr_01),
                // .NPC_isJ_02(NPC_isJ_02),
                // .NPC_isBeq_03(NPC_isBeq_03),
            //ins_parts****************************
                .Rs(Rs_E),
                .Rt(Rt_E),
                .Rd(Rd_E),
                .imm(imm_E),
                .ins_index(ins_index_E),
            //暂停转发******************************
                //1.送出选择
                .Forward_outChoose(Forward_outChoose_E),
                //2.Tuse_Rs Tuse_Rt Tnew
                .Tuse_Rs(Tuse_Rs_E),
                .Tuse_Rt(Tuse_Rt_E),
                .Tnew(Tnew_E),
                //3.是否读写
                .isRead_Rs(isRead_Rs_E),
                .isRead_Rt(isRead_Rt_E),
                .isWrite(isWrite_E),
                .WriteDes(WriteDes_E)
            );
        //ALU
            //选择B
            wire [31:0] tempB;
            assign tempB =
                (ALU_B_01==1'b1)?   imm_HasExted_E:
                                    RD2_E_final;
        ALU myALU (
            .A(RD1_E_final),
            .B(tempB),
            .ALUOp(ALU_Op_03),

            .C(ALU_E)
        );
        //EXT
        EXT myEXT (
            .imm(imm_E),
            .zeroOrSigned(ALU_immExt_02),

            .immHasExted(imm_HasExted_E)
        );
    //M
       //MEM
        DEMW myMEM (
        //三件套
            .clk(clk),
            .reset(reset),
            .en(enMEM),
        //INS( ),PC( ),PC4*******************
            .INS( INS_E),
            .PC(PC_E),
            .PC4(PC4_E),
        //RD1( ),RD2**********************
            .RD1(RD1_E_final),
            .RD2(RD2_E_final),
        //isStandbySuc*****************
            .isStandbySuc(isStanbydSuc_E_final),
        //PC8( ),ALU( ),DM*******************
            .PC8(PC8_E),
            .ALU(ALU_E),
            // .DM(DM_E),
        //standby**********************
            .standby(standby_E_final),


        //INS( ),PC( ),PC4*******************
            .INS_final(INS_M),
            .PC_final(PC_M),
            .PC4_final(PC4_M),
        //RD1( ),RD2**********************
            .RD1_final(RD1_M),
            .RD2_final(RD2_M),
        //isStandbySuc*****************
            .isStandbySuc_final(isStandbySuc_M),
        //PC8( ),ALU( ),DM*******************
            .PC8_final(PC8_M),
            .ALU_final(ALU_M),
            // .DM_final(DM_M),
        //standby**********************
            .standby_final(standby_M)
        );
       //Controller_M
            wire [2:0]  stage_M=3'd3;
            Controller myController_M (
            //输入**********************************
                .ins(INS_M),
                .stage(stage_M),
                .isSuc(standbySuc_M),
            //GRF**********************************
                // .GRF_A3_01(GRF_A3_01),
                // .GRF_WE_02(GRF_WE_02),
            //ALU**********************************
                // .ALU_B_01(ALU_B_01),
                // .ALU_immExt_02(ALU_immExt_02),
                // .ALU_Op_03(ALU_Op_03),
            //DM***********************************
                .DM_WE_01(DM_WE_01),
            //NPC**********************************
                // .NPC_isJr_01(NPC_isJr_01),
                // .NPC_isJ_02(NPC_isJ_02),
                // .NPC_isBeq_03(NPC_isBeq_03),
            //ins_parts****************************
                .Rs(Rs_M),
                .Rt(Rt_M),
                .Rd(Rd_M),
                .imm(imm_M),
                .ins_index(ins_index_M),
            //暂停转发******************************
                //1.送出选择
                .Forward_outChoose(Forward_outChoose_M),
                //2.Tuse_Rs Tuse_Rt Tnew
                .Tuse_Rs(Tuse_Rs_M),
                .Tuse_Rt(Tuse_Rt_M),
                .Tnew(Tnew_M),
                //3.是否读写
                .isRead_Rs(isRead_Rs_M),
                .isRead_Rt(isRead_Rt_M),
                .isWrite(isWrite_M),
                .WriteDes(WriteDes_M)
            );
       //DM 
        DM myDM (
            .A(ALU_M),
            .WD(RD2_M_final),
            .PC_M(PC_M),
            .WE(DM_WE_01),

            .clk(clk),
            .reset(reset),
            
            .RD(DM_M)
        );
    //W
        //WB
        DEMW myWB (
        //三件套
            .clk(clk),
            .reset(reset),
            .en(enWB),
        //INS( ),PC( ),PC4*******************
            .INS( INS_M),
            .PC(PC_M),
            .PC4(PC4_M),
        //RD1( ),RD2**********************
            .RD1(RD1_M_final),
            .RD2(RD2_M_final),
        //isStandbySuc*****************
            .isStandbySuc(isStandbySuc_M_final),
        //PC8( ),ALU( ),DM*******************
            .PC8(PC8_M),
            .ALU(ALU_M),
            .DM(DM_M),
        //standby**********************
            .standby(standby_M_final),


        //INS( ),PC( ),PC4*******************
            .INS_final(INS_W),
            .PC_final(PC_W),
            .PC4_final(PC4_W),
        //RD1( ),RD2**********************
            .RD1_final(RD1_W),
            .RD2_final(RD2_W),
        //isStandbySuc*****************
            .isStandbySuc_final(isStandbySuc_W),
        //PC8( ),ALU( ),DM*******************
            .PC8_final(PC8_W),
            .ALU_final(ALU_W),
            .DM_final(DM_W),
        //standby**********************
            .standby_final(standby_W)
        );
        //Controller_W
            wire [2:0]  stage_W=3'd4;
            Controller myController_W (
            //输入**********************************
                .ins(INS_W),
                .stage(stage_W),
                .isSuc(standbySuc_W),
            //GRF**********************************
                .GRF_A3_01(GRF_A3_01),
                .GRF_WE_02(GRF_WE_02),
            //ALU**********************************
                // .ALU_B_01(ALU_B_01),
                // .ALU_immExt_02(ALU_immExt_02),
                // .ALU_Op_03(ALU_Op_03),
            //DM***********************************
                // .DM_WE_01(DM_WE_01),
            //NPC**********************************
                // .NPC_isJr_01(NPC_isJr_01),
                // .NPC_isJ_02(NPC_isJ_02),
                // .NPC_isBeq_03(NPC_isBeq_03),
            //ins_parts****************************
                .Rs(Rs_W),
                .Rt(Rt_W),
                .Rd(Rd_W),
                .imm(imm_W),
                .ins_index(ins_index_W),
            //暂停转发******************************
                //1.送出选择
                .Forward_outChoose(Forward_outChoose_W),
                //2.Tuse_Rs Tuse_Rt Tnew
                .Tuse_Rs(Tuse_Rs_W),
                .Tuse_Rt(Tuse_Rt_W),
                .Tnew(Tnew_W),
                //3.是否读写
                .isRead_Rs(isRead_Rs_W),
                .isRead_Rt(isRead_Rt_W),
                .isWrite(isWrite_W),
                .WriteDes(WriteDes_W)
            );
    //Hazard
        //Hazard
        Hazard myHazard (
            //D
                //Rs
                .isRead_Rs_D(isRead_Rs_D),
                .Rs_D(Rs_D),
                .Tuse_Rs_D(Tuse_Rs_D),
                //Rt
                .isRead_Rt_D(isRead_Rt_D),
                .Rt_D(Rt_D),
                .Tuse_Rt_D(Tuse_Rt_D),
            //E
                //Write
                .isWrite_E(isWrite_E),
                .WriteDes_E(WriteDes_E),
                .Tnew_E(Tnew_E),
            //M
                //Write
                .isWrite_M(isWrite_M),
                .WriteDes_M(WriteDes_M),
                .Tnew_M(Tnew_M),
            //输出
                .stallPC(stallPC),
                .stallID(stallID),
                .flushEX(flushEX)
        );
    //Forward
        //D <- E M
            //Rs 
                //Rs: D <- E
                ForwardUnit myFW_Rs_DE (
                    //读
                    .isRead(isRead_Rs_D),
                    .ReadDes(Rs_D),
                    .Tuse(Tuse_Rs_D),
                    //写
                    .isWrite(isWrite_E),
                    .WriteDes(WriteDes_E),
                    .Tnew(Tnew_E),

                    //转发
                    .NeedForward(isNeedForward_Rs_DE)
                );
                //Rs: D <- M
                ForwardUnit myFW_Rs_DEM (
                    //读
                    .isRead(isRead_Rs_D),
                    .ReadDes(Rs_D),
                    .Tuse(Tuse_Rs_D),
                    //写
                    .isWrite(isWrite_M),
                    .WriteDes(WriteDes_M),
                    .Tnew(Tnew_M),

                    //转发
                    .NeedForward(isNeedForward_Rs_DEM)
                );
            //Rt 
                //Rt: D <- E
                ForwardUnit myFW_Rt_DE (
                    //读
                    .isRead(isRead_Rt_D),
                    .ReadDes(Rt_D),
                    .Tuse(Tuse_Rt_D),
                    //写
                    .isWrite(isWrite_E),
                    .WriteDes(WriteDes_E),
                    .Tnew(Tnew_E),

                    //转发
                    .NeedForward(isNeedForward_Rt_DE)
                );
                //Rt: D <- M
                ForwardUnit myFW_Rt_DEM (
                    //读
                    .isRead(isRead_Rt_D),
                    .ReadDes(Rt_D),
                    .Tuse(Tuse_Rt_D),
                    //写
                    .isWrite(isWrite_M),
                    .WriteDes(WriteDes_M),
                    .Tnew(Tnew_M),

                    //转发
                    .NeedForward(isNeedForward_Rt_DEM)
                );

        //E <- M W
            //Rs
                //Rs: E <- M
                ForwardUnit myFW_Rs_EM (
                    //读
                    .isRead(isRead_Rs_E),
                    .ReadDes(Rs_E),
                    .Tuse(Tuse_Rs_E),
                    //写
                    .isWrite(isWrite_M),
                    .WriteDes(WriteDes_M),
                    .Tnew(Tnew_M),

                    //转发
                    .NeedForward(isNeedForward_Rs_EM)
                );
                //Rs: E <- W
                ForwardUnit myFW_Rs_EMW (
                    //读
                    .isRead(isRead_Rs_E),
                    .ReadDes(Rs_E),
                    .Tuse(Tuse_Rs_E),
                    //写
                    .isWrite(isWrite_W),
                    .WriteDes(WriteDes_W),
                    .Tnew(Tnew_W),

                    //转发
                    .NeedForward(isNeedForward_Rs_EMW)
                );
            //Rt
                //Rt: E <- M
                ForwardUnit myFW_Rt_EM (
                    //读
                    .isRead(isRead_Rt_E),
                    .ReadDes(Rt_E),
                    .Tuse(Tuse_Rt_E),
                    //写
                    .isWrite(isWrite_M),
                    .WriteDes(WriteDes_M),
                    .Tnew(Tnew_M),

                    //转发
                    .NeedForward(isNeedForward_Rt_EM)
                );
                //Rt: E <- W
                ForwardUnit myFW_Rt_EMW (
                    //读
                    .isRead(isRead_Rt_E),
                    .ReadDes(Rt_E),
                    .Tuse(Tuse_Rt_E),
                    //写
                    .isWrite(isWrite_W),
                    .WriteDes(WriteDes_W),
                    .Tnew(Tnew_W),

                    //转发
                    .NeedForward(isNeedForward_Rt_EMW)
                );

        //M <- W
            //Rs
                //Rs: M <- W
                ForwardUnit myFW_Rs_MW (
                    //读
                    .isRead(isRead_Rs_M),
                    .ReadDes(Rs_M),
                    .Tuse(Tuse_Rs_M),
                    //写
                    .isWrite(isWrite_W),
                    .WriteDes(WriteDes_W),
                    .Tnew(Tnew_W),

                    //转发
                    .NeedForward(isNeedForward_Rs_MW)
                );
            //Rt
                //Rt: M <- W
                ForwardUnit myFW_Rt_MW (
                    //读
                    .isRead(isRead_Rt_M),
                    .ReadDes(Rt_M),
                    .Tuse(Tuse_Rt_M),
                    //写
                    .isWrite(isWrite_W),
                    .WriteDes(WriteDes_W),
                    .Tnew(Tnew_W),

                    //转发
                    .NeedForward(isNeedForward_Rt_MW)
                );

//3.送出信号*************************************************************************************************************************************
    //1.信号声明
        //D:不需要
            wire        isStandbySuc_D_final;
            wire [31:0] standby_D_final;
        //E
            wire        isStandbySuc_E_final;
            wire [31:0] standby_E_final;
            wire [31:0] Data_E;
        //M
            wire        isStandbySuc_M_final;
            wire [31:0] standby_M_final;
            wire [31:0] Data_M;
        //W
            wire [31:0] Data_W;
    //2.选择送出
        //D
            assign standby_D_final = 32'h0000_0000;
            assign isStandbySuc_D_final = 1'b0;
        //E
            assign standby_E_final = standby_E;
            assign isStandbySuc_E_final = standbySuc_E;
            assign Data_E =
                (Forward_outChoose_E==2'b11)?   standby_E_final:
                                                PC8_E;
        //M
            assign standby_M_final = standby_M;
            assign isStandbySuc_M_final = standbySuc_M;
            assign Data_M =
                (Forward_outChoose_M==2'b11)?   standby_M_final:
                (Forward_outChoose_M==2'b01)?   ALU_M:
                                                PC8_M;
        //W
            assign Data_W = 
                (Forward_outChoose_W==2'b11)?   standby_W:
                (Forward_outChoose_W==2'b10)?   DM_W:
                (Forward_outChoose_W==2'b01)?   ALU_W:
                                                PC8_W; 

//4.转发选择*************************************************************************************************************************************
    //1.信号声明
        //D
        wire [31:0] RD1_D_final;
        wire [31:0] RD2_D_final;
        //E
        wire [31:0] RD1_E_final;
        wire [31:0] RD2_E_final;
        //M
        wire [31:0] RD1_M_final;
        wire [31:0] RD2_M_final;
        //W:不需要
    //2.转发选择
        //D
            //RD1_D_final;
            assign RD1_D_final =
                (isNeedForward_Rs_DE)?  Data_E:
                (isNeedForward_Rs_DEM)? Data_M:
                                        RD1_D;
            //RD2_D_final;
            assign RD2_D_final =
                (isNeedForward_Rt_DE)?  Data_E:
                (isNeedForward_Rt_DEM)? Data_M:
                                        RD2_D;
        //E
            //RD1_E_final;
            assign RD1_E_final =
                (isNeedForward_Rs_EM)?  Data_M:
                (isNeedForward_Rs_EMW)? Data_W:
                                        RD1_E;
            //RD2_E_final;
            assign RD2_E_final =
                (isNeedForward_Rt_EM)?  Data_M:
                (isNeedForward_Rt_EMW)? Data_W:
                                        RD2_E;
        //M
            //RD1_M_final;
            assign RD1_M_final =
                (isNeedForward_Rs_MW)?  Data_W:
                                        RD1_M;
            //RD2_M_final;
            assign RD2_M_final =
                (isNeedForward_Rt_MW)?  Data_W:
                                        RD2_M;

endmodule