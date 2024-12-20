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
//输出线路声明************************************************************************************************************************
    //F
        //PC
        wire [31:0] PC_F;
        //IM
        wire [31:0] INS_F;
    //D
        //ID
        wire [31:0] INS_D;
        wire [31:0] PC_D;
        wire [31:0] PC4_D;
        wire [31:0] PC8_D;
        //Controller_D
        wire NPC_isJr_01;
        wire NPC_isJal_02;
        wire NPC_isBranch_03;
        wire [4:0]  Rs_D;
        wire [4:0]  Rt_D;
        wire [4:0]  Rd_D;
        wire [15:0] imm_D;
        wire [25:0] ins_index_D;
        //GRF
        wire [31:0] RD1_D;
        wire [31:0] RD2_D;
        //NPC
        wire [31:0]NPC;
        //CMP
        wire isEqual_CMP;
    //E
        //EX
        wire [31:0] INS_E;
        wire [31:0] PC_E;
        wire [31:0] PC4_E;
        wire [31:0] PC8_E;
        wire [31:0] RD1_E;
        wire [31:0] RD2_E;
        //Controller_E
        wire        ALU_B_01;
        wire        ALU_immExt_02;
        wire [2:0]  ALU_Op_03;
        wire [15:0] imm_E;
        //ALU
        wire [31:0] ALU_C;
        //EXT
        wire [31:0] immHasExted_E;
    //M
        //MEM
        wire [31:0] INS_M;
        wire [31:0] PC_M;
        wire [31:0] PC4_M;
        wire [31:0] PC8_M;
        wire [31:0] ALU_M;
        wire [31:0] Rt_M;
        //Controller_M
        wire DM_WE;
        //DM
        wire [31:0] DM_M;
    //W
        //WB
        wire [31:0] INS_W;
        wire [31:0] PC_W;
        wire [31:0] PC4_W;
        wire [31:0] PC8_W;
        wire [31:0] ALU_W;
        wire [31:0] DM_W;
        //Controller_W
        wire [1:0]  GRF_A3_01;
        wire        GRF_WE_02;
        wire [1:0]  GRF_WD_03;
        wire [4:0]  Rs_W;
        wire [4:0]  Rt_W;
        wire [4:0]  Rd_W;
    //Hazard
        //Hazard
        wire stallPC;
        wire stallID;
        wire flushEX;
    //Forward
        //Forward
            //NPC_Rs
                wire    [1:0]   JReg_NPC_Rs_Choose;
            //CMP
                //Rs
                wire    [1:0]   Beq_CMP_Rs_Choose;
                //Rt
                wire    [1:0]   Beq_CMP_Rt_Choose;
            //ALU
                //Rs
                wire    [2:0]   cal_r_cal_i_load_store_ALU_Rs_Choose;
                //Rt
                wire    [2:0]   cal_r_ALU_Rt_Choose;
            //Store
                //DM
                wire    [1:0]   store_Rt_Choose_DM_M;
                //Rt_E
                wire    [1:0]   store_Rt_Choose_Rt_E;




//使能线路声明************************************************************************************************************************
    //PC 用Hazard stallPC
    //ID 用Hazard stallID
    //EX 用Hazard的(flushEX||reset) 同时en恒为1
    wire enEX;
    assign enEX=1;
    //MEM en恒为1
    wire enMEM;
    assign enMEM=1;
    //WB en恒为1
    wire enWB;
    assign enWB=1;




//连接模块****************************************************************************************************************************
    //F
        //PC
        PC myPC(
            .clk(clk),
            .reset(reset),
            .en(~stallPC),
            .NPC(NPC),
            .PC(PC_F)
        );
        //IM
        IM myIM(
            .PC(PC_F),
            .Ins(INS_F)
        );
    //D
        //ID
        ID myID(
            .clk(clk),
            .reset(reset),
            .en(~stallID),

            .INS_F(INS_F),
            .PC_F(PC_F),

            .INS_D(INS_D),
            .PC_D(PC_D),
            .PC4_D(PC4_D),
            .PC8_D(PC8_D)
        );
        //Controller_D
        Controller Controller_D(
        //ins**********************************
            .ins(INS_D),
        //GRF**********************************
            // .[1:0]GRF_A3_01( ),
            // .     GRF_WE_02( ),
            // .[1:0]GRF_WD_03( ),
        //ALU**********************************
            // .     ALU_B_01( ),
            // .     ALU_immExt_02( ),
            // .[2:0]ALU_Op_03( ),
        //DM***********************************
            // .     DM_WE_01( ),
        //NPC**********************************
            .NPC_isJr_01(NPC_isJr_01),
            .NPC_isJal_02(NPC_isJal_02),
            .NPC_isBranch_03(NPC_isBranch_03),
        //ins_parts****************************
            .Rs(Rs_D),
            .Rt(Rt_D),
            .Rd(Rd_D),
            .imm(imm_D),
            .ins_index(ins_index_D)
        );
        //GRF
            //A3端口选择
            wire [4:0]  tempGRF_A3;
            assign tempGRF_A3 = 
                (GRF_A3_01==2'b10)? 5'd31:
                (GRF_A3_01==2'b01)? Rt_W:
                Rd_W;
            //WD端口选择
            wire [31:0] tempGRF_WD;
            assign tempGRF_WD = 
                (GRF_WD_03==2'b10)? PC8_W:
                (GRF_WD_03==2'b01)? DM_W:
                ALU_W;
        GRF myGRF(
            .clk(clk),
            .reset(reset),

            .PC_W(PC_W),
            .A1(Rs_D),
            .A2(Rt_D),
            .A3(tempGRF_A3),
            .WD(tempGRF_WD),
            .WE(GRF_WE_02),

            .RD1(RD1_D),
            .RD2(RD2_D)
        );
        //NPC
            //Rs选择
            //10-ALU_M 01-PC8_M 00-RD1
            wire [31:0]tempNPC_Rs;
            assign tempNPC_Rs = 
                (JReg_NPC_Rs_Choose==2'b10)?    ALU_M:
                (JReg_NPC_Rs_Choose==2'b01)?    PC8_M:
                RD1_D;
        NPC myNPC(
            .PC_F(PC_F),
            .PC_D(PC_D),

            .rs(tempNPC_Rs),
            .imm(imm_D),
            .ins_index(ins_index_D),

            .isJr(NPC_isJr_01),
            .isJal(NPC_isJal_02),
            .isBranch(NPC_isBranch_03),
            .isBranchSuccess(isEqual_CMP),

            .NPC(NPC)
        );
        //CMP
            //CMP_Rs选择
            //10-ALU_M 01-PC8_M 00-RD1
            wire [31:0] tempCMP_Rs;
            assign tempCMP_Rs = 
                (Beq_CMP_Rs_Choose==2'b10)? ALU_M:
                (Beq_CMP_Rs_Choose==2'b01)? PC8_M:
                RD1_D;
            //CMP_Rt选择
            //10-ALU_M 01-PC8_M 00-RD2
            wire [31:0] tempCMP_Rt;
            assign tempCMP_Rt =
                (Beq_CMP_Rt_Choose==2'b10)? ALU_M:
                (Beq_CMP_Rt_Choose==2'b01)? PC8_M:
                RD2_D;
        CMP myCMP(
            .Rs(tempCMP_Rs),
            .Rt(tempCMP_Rt),

            .isEqual(isEqual_CMP)
        );
    //E
        //EX
            //flush整合进reset
            wire tempReset_EX;
            assign tempReset_EX = (reset||flushEX);
        EX myEX(
            //时钟
            .clk(clk),
            .reset(tempReset_EX),
            .en(enEX),

            //指令
            .INS_D(INS_D),
            .PC_D(PC_D),
            .PC4_D(PC4_D),
            .PC8_D(PC8_D),
            //GRF读出
            .RD1_D(RD1_D),
            .RD2_D(RD2_D),

            //指令
            .INS_E(INS_E),
            .PC_E(PC_E),
            .PC4_E(PC4_E),
            .PC8_E(PC8_E),
            //GRF读出
            .RD1_E(RD1_E),
            .RD2_E(RD2_E)
        );
        //Controller_E
        Controller Controller_E(
        //ins**********************************
            .ins(INS_E),
        //GRF**********************************
            // .[1:0]GRF_A3_01( ),
            // .     GRF_WE_02( ),
            // .[1:0]GRF_WD_03( ),
        //ALU**********************************
            .ALU_B_01(ALU_B_01),
            .ALU_immExt_02(ALU_immExt_02),
            .ALU_Op_03(ALU_Op_03),
        //DM***********************************
            // .     DM_WE_01( ),
        //NPC**********************************
            // .     NPC_isJr_01( ),
            // .     NPC_isJal_02( ),
            // .     NPC_isBranch_03( ),
        //ins_parts****************************
            // .[4:0]    Rs( ),
            // .[4:0]    Rt( ),
            // .[4:0]    Rd( ),
            .imm(imm_E)
            // .[25:0]   ins_index
        );
        //ALU
            //ALU_Rs选择
            //100-ALU_M 011-ALU_W 010-DM_W 001-PC8_W 000-RD1_E
            wire [31:0] tempALU_Rs;
            assign tempALU_Rs = 
                (cal_r_cal_i_load_store_ALU_Rs_Choose==3'b101)? ALU_M:
                (cal_r_cal_i_load_store_ALU_Rs_Choose==3'b100)? PC8_M:
                (cal_r_cal_i_load_store_ALU_Rs_Choose==3'b011)? ALU_W:
                (cal_r_cal_i_load_store_ALU_Rs_Choose==3'b010)? DM_W:
                (cal_r_cal_i_load_store_ALU_Rs_Choose==3'b001)? PC8_W:
                RD1_E;
            //ALU_B选择
            wire [31:0] tempALU_B;
            assign tempALU_B =
                (ALU_B_01==1'b1)?   immHasExted_E:
                tempALU_Rt;
                //ALU_Rt选择
                //100-ALU_M 011-ALU_W 010-DM_W 001-PC8_W 000-RD2_E
                wire [31:0] tempALU_Rt;
                assign tempALU_Rt = 
                    (cal_r_ALU_Rt_Choose==3'b101)?  ALU_M:
                    (cal_r_ALU_Rt_Choose==3'b100)?  PC8_M:
                    (cal_r_ALU_Rt_Choose==3'b011)?  ALU_W:
                    (cal_r_ALU_Rt_Choose==3'b010)?  DM_W:
                    (cal_r_ALU_Rt_Choose==3'b001)?  PC8_W:
                    RD2_E;
        ALU myALU(
            .A(tempALU_Rs),
            .B(tempALU_B),
            .ALUOp(ALU_Op_03),

            .C(ALU_C)
        );
        //EXT
        EXT myEXT(
            .imm(imm_E),
            .zeroOrSigned(ALU_immExt_02),

            .immHasExted(immHasExted_E)
        );
    //M
        //MEM
            //Store Rt_E的选择
            //11-ALU_W 10-DM_W 01-PC8_W 00-RD2_E
            wire [31:0] tempRt_E;
            assign tempRt_E = 
                (store_Rt_Choose_Rt_E==2'b11)?  ALU_W:
                (store_Rt_Choose_Rt_E==2'b10)?  DM_W:
                (store_Rt_Choose_Rt_E==2'b01)?  PC8_W:
                RD2_E;
        MEM myMEM(
            //时钟
            .clk(clk),
            .reset(reset),
            .en(enMEM),

            //指令
            .INS_E(INS_E),
            .PC_E(PC_E),
            .PC4_E(PC4_E),
            .PC8_E(PC8_E),
            //GRF读出
            .ALU_E(ALU_C),
            .Rt_E(tempRt_E),

            //指令
            .INS_M(INS_M),
            .PC_M(PC_M),
            .PC4_M(PC4_M),
            .PC8_M(PC8_M),
            //GRF读出
            .ALU_M(ALU_M),
            .Rt_M(Rt_M)
        );
        //Controller_M
        Controller COntroller_M(
        //ins**********************************
            .ins(INS_M),
        //GRF**********************************
            // .[1:0]GRF_A3_01( ),
            // .     GRF_WE_02( ),
            // .[1:0]GRF_WD_03( ),
        //ALU**********************************
            // .     ALU_B_01( ),
            // .     ALU_immExt_02( ),
            // .[2:0]ALU_Op_03( ),
        //DM***********************************
            .DM_WE_01(DM_WE)
        //NPC**********************************
            // .     NPC_isJr_01( ),
            // .     NPC_isJal_02( ),
            // .     NPC_isBranch_03( ),
        //ins_parts****************************
            // .[4:0]    Rs( ),
            // .[4:0]    Rt( ),
            // .[4:0]    Rd( ),
            // .[15:0]   imm( ),
            // .[25:0]   ins_index
        );
        //DM
            //DM的Rt端口选择
            //11-ALU_W 10-DM_W 01-PC8_W 00-Rt_M
            wire [31:0] tempDM_WD;
            assign tempDM_WD = 
                (store_Rt_Choose_DM_M==2'b11)?  ALU_W:
                (store_Rt_Choose_DM_M==2'b10)?  DM_W:
                (store_Rt_Choose_DM_M==2'b01)?  PC8_W:
                Rt_M;
        DM myDM(
            .A(ALU_M),
            .WD(tempDM_WD),
            .PC_M(PC_M),
            .WE(DM_WE),

            .clk(clk),
            .reset(reset),
            
            .RD(DM_M)
        );
    //W
        //WB
        WB myWB(
            //时钟
            .clk(clk),
            .reset(reset),
            .en(enWB),

            //指令
            .INS_M(INS_M),
            .PC_M(PC_M),
            .PC4_M(PC4_M),
            .PC8_M(PC8_M),
            //GRF读出
            .ALU_M(ALU_M),
            .DM_M(DM_M),

            //指令
            .INS_W(INS_W),
            .PC_W(PC_W),
            .PC4_W(PC4_W),
            .PC8_W(PC8_W),
            //GRF读出
            .ALU_W(ALU_W),
            .DM_W(DM_W)
        );
        //Controller_W
        Controller Controller_M(
        //ins**********************************
            .ins(INS_W),
        //GRF**********************************
            .GRF_A3_01(GRF_A3_01),
            .GRF_WE_02(GRF_WE_02),
            .GRF_WD_03(GRF_WD_03),
        //ALU**********************************
            // .     ALU_B_01( ),
            // .     ALU_immExt_02( ),
            // .[2:0]ALU_Op_03( ),
        //DM***********************************
            // .     DM_WE_01( ),
        //NPC**********************************
            // .     NPC_isJr_01( ),
            // .     NPC_isJal_02( ),
            // .     NPC_isBranch_03( ),
        //ins_parts****************************
            .Rs(Rs_W),
            .Rt(Rt_W),
            .Rd(Rd_W)
            // .[15:0]   imm( ),
            // .[25:0]   ins_index
        );
    //Hazard
        //Hazard
        Hazard myHazard(
            .INS_D(INS_D),
            .INS_E(INS_E),
            .INS_M(INS_M),

            .stallPC(stallPC),
            .stallID(stallID),
            .flushEX(flushEX)
        );
    //Forward
        //Forward
        Forward myForward(
            .INS_D(INS_D),
            .INS_E(INS_E),
            .INS_M(INS_M),
            .INS_W(INS_W),

            //NPC
            .JReg_NPC_RsChoose(JReg_NPC_Rs_Choose),
            //CMP
            .Beq_CMP_RsChoose(Beq_CMP_Rs_Choose),
            .Beq_CMP_RtChoose(Beq_CMP_Rt_Choose),
            //ALU
            .cal_r_cal_i_load_store_ALU_RsChoose(cal_r_cal_i_load_store_ALU_Rs_Choose),
            .cal_r_ALU_RtChoose(cal_r_ALU_Rt_Choose),
            //Store
            .store_RtChoose_DM_M(store_Rt_Choose_DM_M),
            .store_RtChoose_Rt_E(store_Rt_Choose_Rt_E)
        );

endmodule
