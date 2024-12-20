module mips(
    input clk,
    input reset,

    //////// PC_F 和 IN_F ///////
    output  [31:0]  i_inst_addr,  
    input   [31:0]  i_inst_rdata, 

    //// DM_A; RD2_M_final; 位宽使能; PC_M ////
    ///////////////// DM_RD /////////////////
    output  [31:0]  m_data_addr,
    output  [31:0]  m_data_wdata,
    output  [3:0]   m_data_byteen,
    output  [31:0]  m_inst_addr,
    input   [31:0]  m_data_rdata,

    output          w_grf_we,
    output [4:0]    w_grf_addr,
    output [31:0]   w_grf_wdata,
    output [31:0]   w_inst_addr
);

//1.输出线路信号声明****************************************************************************************************

    // F ************************************************************************
        // PC and IM
        wire [31:0] PC_F, IN_F;

    // DEMW *********************************************************************
        //ID
        wire [31:0] IN_D, PC_D;
        //EX
        wire [31:0] IN_E, PC_E;
        wire [4:0]  A3_E;
        wire [1:0]  Tuse_Rs_E;
        wire [1:0]  Tuse_Rt_E;
        wire [1:0]  Tnew_E;
        wire [31:0] RD1_E;
        wire [31:0] RD2_E;
        wire [31:0] Data_E;
        //MEM
        wire [31:0] IN_M, PC_M;
        wire [4:0]  A3_M;
        wire [1:0]  Tuse_Rs_M;
        wire [1:0]  Tuse_Rt_M;
        wire [1:0]  Tnew_M;
        wire [31:0] RD1_M;
        wire [31:0] RD2_M;
        wire [31:0] Data_M;
        wire [31:0] DM_A;
        //WB
        wire [31:0] IN_W, PC_W;
        wire [4:0]  A3_W;
        wire [1:0]  Tuse_Rs_W;
        wire [1:0]  Tuse_Rt_W;
        wire [1:0]  Tnew_W;
        wire [31:0] RD1_W;
        wire [31:0] RD2_W;
        wire [31:0] Data_W;

    // Controller *******************************************************************
        // D-stage need to parse A3 Tuse Tnew and E-M-W to flow them
        wire NPC_isJr_01,   NPC_isJ_02,     NPC_isBranch_03;
        wire CMP_Select;
        wire isMDFT_D;
        wire OutSelect_D;

        wire [4:0] A3_D;
        wire [1:0] Tuse_Rs_D,   Tuse_Rt_D,  Tnew_D;

        wire isRead_Rs_D,   isRead_Rt_D;
        
        // E-stage need to finish ALU control
        //////////// ALU ////////////
        wire ALU_B_01,  ALU_immExt_02;
        wire [3:0] ALU_Op_03;
        //////////// MDU ////////////
        wire MDU_Start_01;
        wire [2:0]  MDU_Op_02;
        wire MDU_HI_Write_03,   MDU_LO_Write_04;
        ///// OutSelect E-stage /////
        wire [1:0] OutSelect_E;

        wire isRead_Rs_E,   isRead_Rt_E;

        // M-stage need to finish DM control DM-Width 2 means byte 1 means half 0 means word
        wire DM_WE_01;
        wire [1:0] DM_Width_02;
        wire OutSelect_M;

        wire isRead_Rs_M,   isRead_Rt_M;

        // W-stage no-use
        wire isRead_Rs_W,   isRead_Rt_W;

    // Decode *********************************************************************
        //GRF
        wire [31:0] RD1_D,  RD2_D;
        //NPC
        wire [31:0] NPC;
        //CMP
        wire isSuc_CMP;
        //进入流水的数据
        wire [31:0] Data_D_final;

    // Execute *********************************************************************
        //ALU
        wire [31:0] ALU_C;
        //MDU
        wire [31:0] HI, LO;
        wire E_Busy;
        //EXT
        wire [31:0] imm_E_final;
        //进入流水的数据
        wire [31:0] Data_E_final;

    // Memory ********************************************************************
        //BE-WD
        wire [31:0] DM_WD;
        wire [3:0]  DM_Byteen;
        //BE_RD
        wire [31:0] DM_RD;
        //进入流水的数据
        wire [31:0] Data_M_final;

    // WB *************************************************************************
        /*无*/

    // HazardForward ***************************************************************
        //Hazard
        wire stallPC, stallID, flushEX;
        //Forward
        wire [31:0] RD1_D_final, RD2_D_final;
        wire [31:0] RD1_E_final, RD2_E_final;
        wire [31:0] RD1_M_final, RD2_M_final;

//2.顶层电路其他信号****************************************************************************************************
    //EX,MEM,WB enable signal
    wire enEX,  enMEM,  enWB;
    assign enEX = 1'b1;
    assign enMEM = 1'b1;
    assign enWB = 1'b1;
    //INS slices
    wire [4:0]  Rs_D,    Rt_D,   Rd_D;
    wire [15:0] imm_D;
    wire [25:0] ins_index_D; 

    wire [4:0]  Rs_E,    Rt_E,   Rd_E;
    wire [15:0] imm_E;
    wire [25:0] ins_index_E; 

    wire [4:0]  Rs_M,    Rt_M,   Rd_M;
    wire [15:0] imm_M;
    wire [25:0] ins_index_M; 

    wire [4:0]  Rs_W,    Rt_W,   Rd_W;
    wire [15:0] imm_W;
    wire [25:0] ins_index_W; 
    `define rs 25:21
    `define rt 20:16
    `define rd 15:11
    `define imm16 15:0
    `define imm26 25:0
    //IN_D
    assign Rs_D         = IN_D[`rs];
    assign Rt_D         = IN_D[`rt];
    assign Rd_D         = IN_D[`rd];
    assign imm_D        = IN_D[`imm16];
    assign ins_index_D  = IN_D[`imm26];
    //IN_E
    assign Rs_E         = IN_E[`rs];
    assign Rt_E         = IN_E[`rt];
    assign Rd_E         = IN_E[`rd];
    assign imm_E        = IN_E[`imm16];
    assign ins_index_E  = IN_E[`imm26];
    //IN_M
    assign Rs_M         = IN_M[`rs];
    assign Rt_M         = IN_M[`rt];
    assign Rd_M         = IN_M[`rd];
    assign imm_M        = IN_M[`imm16];
    assign ins_index_M  = IN_M[`imm26];
    //IN_W
    assign Rs_W         = IN_W[`rs];
    assign Rt_W         = IN_W[`rt];
    assign Rd_W         = IN_W[`rd];
    assign imm_W        = IN_W[`imm16];
    assign ins_index_W  = IN_W[`imm26];

//3.连接模块***********************************************************************************************************
    // F *****************************************************************************
        //PC
        PC u_PC(
            .clk   	( clk       ),
            .reset 	( reset     ),
            .en    	( ~stallPC  ),

            .NPC   	( NPC       ),
            .PC    	( PC_F      )
        );
        
        //IM
        assign i_inst_addr = PC_F;
        assign IN_F = i_inst_rdata;
        
    // DEMW *****************************************************************************
        //ID
        DEMW ID(
            .clk       	( clk           ),
            .reset     	( reset         ),
            .en        	( ~stallID      ),

            .INS       	( IN_F        ),
            .PC        	( PC_F         ),
            
            .INS_n     	( IN_D    ),
            .PC_n      	( PC_D     )
        );
        
        //EX
        wire tmp_01;
        assign tmp_01 = (reset||flushEX);
        DEMW EX(
            .clk       	( clk           ),
            .reset     	( tmp_01  ),
            .en        	( enEX         ),

            .INS       	( IN_D       ),
            .PC        	( PC_D         ),
            .A3        	( A3_D         ),
            .Tuse_Rs   	( Tuse_Rs_D    ),
            .Tuse_Rt   	( Tuse_Rt_D    ),
            .Tnew      	( Tnew_D       ),
            .RD1       	( RD1_D_final        ),
            .RD2       	( RD2_D_final        ),
            .Data      	( Data_D_final       ),
            
            .INS_n     	( IN_E      ),
            .PC_n      	( PC_E       ),
            .A3_n      	( A3_E       ),
            .Tuse_Rs_n 	( Tuse_Rs_E  ),
            .Tuse_Rt_n 	( Tuse_Rt_E  ),
            .Tnew_n    	( Tnew_E     ),
            .RD1_n     	( RD1_E      ),
            .RD2_n     	( RD2_E      ),
            .Data_n    	( Data_E     )
        );
        
        //MEM
        ///////////////////////// lwer ////////////////////////////
        wire [4:0] A3_M_temp;
        assign A3_M = (A3_M_temp===5'bz)? A3_M_b1 : A3_M_temp;
        wire [4:0] A3_M_b1;
        wire isDMRDBiggerThanRD2MFinal;
        assign isDMRDBiggerThanRD2MFinal = $signed(DM_RD) > $signed(RD2_M_final);
        assign A3_M_b1 = (isDMRDBiggerThanRD2MFinal)? 5'd5 : 5'd4; 
        ///////////////////////////////////////////////////////////
        DEMW MEM(
            .clk       	( clk           ),
            .reset     	( reset  ),
            .en        	( enMEM         ),

            .INS       	( IN_E       ),
            .PC        	( PC_E         ),
            .A3        	( A3_E         ),
            .Tuse_Rs   	( Tuse_Rs_E    ),
            .Tuse_Rt   	( Tuse_Rt_E    ),
            .Tnew      	( Tnew_E       ),
            .RD1       	( RD1_E_final        ),
            .RD2       	( RD2_E_final        ),
            .Data      	( Data_E_final       ),
            .ALU        ( ALU_C     ),
            
            .INS_n     	( IN_M      ),
            .PC_n      	( PC_M       ),
            .A3_n      	( A3_M_temp       ),
            .Tuse_Rs_n 	( Tuse_Rs_M  ),
            .Tuse_Rt_n 	( Tuse_Rt_M  ),
            .Tnew_n    	( Tnew_M     ),
            .RD1_n     	( RD1_M      ),
            .RD2_n     	( RD2_M      ),
            .Data_n    	( Data_M     ),
            .ALU_n      ( DM_A       )
        );

        //WB
        DEMW WB(
            .clk       	( clk           ),
            .reset     	( reset  ),
            .en        	( enWB         ),

            .INS       	( IN_M       ),
            .PC        	( PC_M         ),
            .A3        	( A3_M         ),
            .Tuse_Rs   	( Tuse_Rs_M    ),
            .Tuse_Rt   	( Tuse_Rt_M    ),
            .Tnew      	( Tnew_M       ),
            .RD1       	( RD1_M_final        ),
            .RD2       	( RD2_M_final        ),
            .Data      	( Data_M_final       ),
            
            .INS_n     	( IN_W      ),
            .PC_n      	( PC_W       ),
            .A3_n      	( A3_W       ),
            .Tuse_Rs_n 	( Tuse_Rs_W  ),
            .Tuse_Rt_n 	( Tuse_Rt_W  ),
            .Tnew_n    	( Tnew_W     ),
            .RD1_n     	( RD1_W      ),
            .RD2_n     	( RD2_W      ),
            .Data_n    	( Data_W     )
        );

    // Controller *****************************************************************************
        // Controller-D
        Controller u_Controller_D(
            .ins           	( IN_D           ),

            .NPC_isJr_01   	( NPC_isJr_01    ),
            .NPC_isJ_02    	( NPC_isJ_02     ),
            .NPC_isBranch_03  	( NPC_isBranch_03   ),
            .CMP_Select     ( CMP_Select),
            .isMDFT           ( isMDFT_D  ),
            .OutSelect_D   	( OutSelect_D    ),
            .A3_D          	( A3_D           ),
            .Tuse_Rs_D     	( Tuse_Rs_D      ),
            .Tuse_Rt_D     	( Tuse_Rt_D      ),
            .Tnew_D        	( Tnew_D         ),
           
            .isRead_Rs     	( isRead_Rs_D      ),
            .isRead_Rt     	( isRead_Rt_D      )
        );
        
        // Controller-E
        Controller u_Controller_E(
            .ins           	( IN_E            ),
            
            .ALU_B_01      	( ALU_B_01       ),
            .ALU_immExt_02 	( ALU_immExt_02  ),
            .ALU_Op_03     	( ALU_Op_03      ),
            .MDU_Start_01   (MDU_Start_01   ),
            .MDU_Op_02      (MDU_Op_02      ),
            .MDU_HI_Write_03(MDU_HI_Write_03),
            .MDU_LO_Write_04(MDU_LO_Write_04),
            .OutSelect_E   	( OutSelect_E    ),
            
            .isRead_Rs     	( isRead_Rs_E      ),
            .isRead_Rt     	( isRead_Rt_E      )
        );
        
        // Controller-M
        Controller u_Controller_M(
            .ins           	( IN_M            ),
            
            .DM_WE_01      	( DM_WE_01       ),
            .DM_Width_02    ( DM_Width_02 ),
            .OutSelect_M   	( OutSelect_M    ),

            .isRead_Rs     	( isRead_Rs_M      ),
            .isRead_Rt     	( isRead_Rt_M      )
        );
        
        // Controller-W
        Controller u_Controller_W(
            .ins           	( IN_W            ),
            
            .isRead_Rs     	( isRead_Rs_W      ),
            .isRead_Rt     	( isRead_Rt_W      )
        );
        
    //Decode*****************************************************************************
        //GRF
        GRF u_GRF(
            .clk   	( clk    ),
            .reset 	( reset  ),
            .PC_W  	( PC_W   ),
            .A1    	( Rs_D    ),
            .A2    	( Rt_D    ),
            .A3    	( A3_W     ),
            .WD    	( Data_W     ),
            .RD1   	( RD1_D    ),
            .RD2   	( RD2_D   )
        );
        assign w_grf_we     = ((A3_W!=5'd0)&(!(A3_W===5'bx)));
        assign w_grf_addr   = A3_W;
        assign w_grf_wdata  = Data_W;
        assign w_inst_addr  = PC_W;

        //NPC
        wire tmp_02;
        assign tmp_02 = (NPC_isBranch_03 & isSuc_CMP);
        NPC u_NPC(
            .PC_F            	( PC_F             ),
            .PC_D            	( PC_D             ),
            .rs              	( RD1_D_final      ),
            .imm             	( imm_D             ),
            .ins_index       	( ins_index_D        ),
            .isJr            	( NPC_isJr_01           ),
            .isJ             	( NPC_isJ_02             ),
            .isBranchSuccess 	( tmp_02  ),
            .NPC             	( NPC              )
        );
        
        //CMP
        CMP u_CMP(
            .Rs      	( RD1_D_final       ),
            .Rt      	(  RD2_D_final       ),
            .CMP_Select (CMP_Select),
            .isSuc 	    ( isSuc_CMP )
        );
        
    //Execute
        //EXT
        EXT u_EXT(
            .imm          	( imm_E           ),
            .zeroOrSigned 	( ALU_immExt_02  ),
            .immHasExted  	( imm_E_final   )
        );
        //ALU
        wire [31:0] tmp_03;
        assign tmp_03 = 
            (ALU_B_01)? imm_E_final: 
                        RD2_E_final;
        ALU u_ALU(
            .A     	( RD1_E_final      ),
            .B     	( tmp_03      ),
            .ALUOp 	( ALU_Op_03  ),
            .C     	( ALU_C      )
        );
        //MDU
        MDU u_MDU(
            .clk        (clk),
            .reset      (reset),
            .start      (MDU_Start_01),
            .A          (RD1_E_final),
            .B          (RD2_E_final),
            .MDU_Op     (MDU_Op_02),
            .HI_Write   (MDU_HI_Write_03),
            .LO_Write   (MDU_LO_Write_04),
            .HI         (HI),
            .LO         (LO),
            .busy       (E_Busy)
        );
        
    //Memory
        BE_WD u_BE_WD(
                .RD2_M_final    (RD2_M_final),
                .DM_A           (DM_A),
                .DM_WE_01       (DM_WE_01),
                .DM_Width_02    (DM_Width_02),

                .DM_WD_11       (DM_WD),
                .DM_Byteen_12   (DM_Byteen)
        );
        assign m_data_addr      = DM_A;
        assign m_data_wdata     = DM_WD;
        assign m_data_byteen    = DM_Byteen;
        assign m_inst_addr      = PC_M;
        BE_RD u_BE_RD(
            .DM_RD          (m_data_rdata),
            .DM_A           (DM_A),
            .DM_Width_02    (DM_Width_02),

            .DM_RD_13       (DM_RD)
        );
        
    //WB
        /*无*/

    //HazardForward*****************************************************************************
        //Hazard
        Hazard u_Hazard(
            /////////// D-stage /////////////
            .isRead_Rs_D 	( isRead_Rs_D  ),
            .Tuse_Rs_D   	( Tuse_Rs_D    ),
            .Rs_D        	( Rs_D         ),
            .isRead_Rt_D 	( isRead_Rt_D  ),
            .Tuse_Rt_D   	( Tuse_Rt_D    ),
            .Rt_D        	( Rt_D         ),
            .isMDFT_D       ( isMDFT_D     ),
            /////////// E-stage /////////////
            .A3_E        	( A3_E         ),
            .Tnew_E      	( Tnew_E       ),
            .E_Start        ( MDU_Start_01 ),
            .E_Busy         ( E_Busy       ),
            /////////// M-stage /////////////
            .A3_M        	( A3_M         ),
            .Tnew_M      	( Tnew_M       ),
            //////////// stall //////////////
            .stallPC     	( stallPC      ),
            .stallID     	( stallID      ),
            .flushEX     	( flushEX      )
        );
        
        //Forward
        Forward u_Forward(
            .D_A1        	( Rs_D         ),
            .D_A2        	( Rt_D         ),
            .D_Use_1     	( isRead_Rs_D      ),
            .D_Use_2     	( isRead_Rt_D      ),
            .D_RD1       	( RD1_D        ),
            .D_RD2       	( RD2_D        ),
            .D_A3        	( A3_D         ),

            .E_A1        	( Rs_E         ),
            .E_A2        	( Rt_E         ),
            .E_Use_1     	( isRead_Rs_E      ),
            .E_Use_2     	( isRead_Rt_E      ),
            .E_RD1       	( RD1_E        ),
            .E_RD2       	(  RD2_E        ),
            .E_A3        	( A3_E         ),

            .M_A1        	( Rs_M         ),
            .M_A2        	( Rt_M         ),
            .M_Use_1     	( isRead_Rs_M      ),
            .M_Use_2     	( isRead_Rt_M      ),
            .M_RD1       	( RD1_M        ),
            .M_RD2       	(  RD2_M        ),
            .M_A3        	( A3_M         ),

            .W_A3        	( A3_W         ),

            .Data_E      	( Data_E       ),
            .Data_M      	( Data_M       ),
            .Data_W      	( Data_W       ),

            .RD1_D_final 	( RD1_D_final  ),
            .RD2_D_final 	( RD2_D_final  ),
            .RD1_E_final 	( RD1_E_final  ),
            .RD2_E_final 	( RD2_E_final  ),
            .RD1_M_final 	( RD1_M_final  ),
            .RD2_M_final 	( RD2_M_final  )
        );

// 4.送出选择 **********************************************************************************************************
    //Decode
    assign Data_D_final = (OutSelect_D)?    (PC_D+32'h0000_0008) : 32'bz;
    //Execute
    assign Data_E_final = 
        (OutSelect_E==2'd3)?    LO: 
        (OutSelect_E==2'd2)?    HI: 
        (OutSelect_E==2'd1)?    ALU_C: 
                                Data_E;
    //Memory
    assign Data_M_final = (OutSelect_M)?    DM_RD : Data_M;

endmodule
