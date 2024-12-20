module CPU(
    input           clk,
    input           reset,
    input [5:0]     HWInt,

    //////////////// 宏PC /////////////////
    output  [31:0]  macroscopic_pc,

    ///////////////// IM /////////////////
    output  [31:0]  i_inst_addr,  
    input   [31:0]  i_inst_rdata, 

    ///////////////// DM /////////////////
    output  [31:0]  m_data_addr,
    output  [31:0]  m_data_wdata,
    output  [3:0]   m_data_byteen,
    input   [31:0]  m_data_rdata,
    output  [31:0]  m_inst_addr,

    output          w_grf_we,
    output [4:0]    w_grf_addr,
    output [31:0]   w_grf_wdata,
    output [31:0]   w_inst_addr
);

//1.输出线路信号声明****************************************************************************************************

    // F ******************************************************************************************
        // PC and IM
        wire [31:0] PC_F, IN_F;
        wire [4:0] ExcCode_F;

    // DEMW ***************************************************************************************
        //ID
        wire [31:0] IN_D, PC_D;
        wire        BD_D;
        wire [4:0]  ExcCode_D;
        //EX
        wire [31:0] IN_E, PC_E;
        wire [4:0]  A3_E;
        wire [1:0]  Tuse_Rs_E;
        wire [1:0]  Tuse_Rt_E;
        wire [1:0]  Tnew_E;
        wire [31:0] RD1_E;
        wire [31:0] RD2_E;
        wire [31:0] Data_E;
        wire        BD_E;
        wire [4:0]  ExcCode_E;
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
        wire        BD_M;
        wire [4:0]  ExcCode_M;
        //WB
        wire [31:0] IN_W, PC_W;
        wire [4:0]  A3_W;
        wire [1:0]  Tuse_Rs_W;
        wire [1:0]  Tuse_Rt_W;
        wire [1:0]  Tnew_W;
        wire [31:0] RD1_W;
        wire [31:0] RD2_W;
        wire [31:0] Data_W;
        wire        BD_W;
        wire [4:0]  ExcCode_W;

    // Controller *********************************************************************************
        // D-stage need to parse A3 Tuse Tnew and E-M-W to flow them ***********************
        ///////////// NPC CMP isMDFT OutSelect_D //////////////
        wire        NPC_isJr_01,   NPC_isJ_02,     NPC_isBranch_03;
        wire        CMP_Select;
        wire        isMDFT_D;
        wire        OutSelect_D;
        ///////////// Hazard Forward need to flow /////////////
        wire [4:0]  A3_D;
        wire [1:0]  Tuse_Rs_D,   Tuse_Rt_D,  Tnew_D;
        ////////// BD back to ID + ExcCode choose /////////////
        wire        BD;
        wire        RI,     isSyscall;
        ///////////// Hazard Forward need to know /////////////
        wire        isRead_Rs_D,   isRead_Rt_D;
        wire        isEret_D;
        
        // E-stage need to finish ALU control *********************************************
        /////////////// ALU + MDU + OutSelect_E ///////////////
        wire        ALU_B_01,  ALU_immExt_02;
        wire [3:0]  ALU_Op_03;
        wire        MDU_Start_01;
        wire [2:0]  MDU_Op_02;
        wire        MDU_HI_Write_03,   MDU_LO_Write_04;
        wire [1:0]  OutSelect_E;
        ///////////////// Overflow type judge /////////////////
        wire        Ov_E,  Ld_E,   St_E;
        ///////////// Hazard Forward need to know /////////////
        wire        isRead_Rs_E,   isRead_Rt_E;
        wire        ismtc0_E;

        // M-stage need to finish DM control DM-Width 2 means byte 1 means half 0 means word
        //////////////////// DM + OutSelect_M //////////////////
        wire        DM_WE_01;
        wire [1:0]  DM_Width_02;
        wire [1:0]  OutSelect_M;
        ///////////////////// type judge //////////////////////
        wire        Ld_M,  St_M;
        ///////////////////////// CP0 /////////////////////////
        wire        CP0_WE,    isEret_M;
        ///////////// Hazard Forward need to know /////////////
        wire isRead_Rs_M,   isRead_Rt_M;
        wire ismtc0_M;

        // W-stage no-use *****************************************************************
        ///////////// Hazard Forward need to know /////////////
        wire isRead_Rs_W,   isRead_Rt_W;

    // Decode *************************************************************************************
        //GRF
        wire [31:0] RD1_D,  RD2_D;
        //NPC
        wire [31:0] NPC;
        //CMP
        wire isSuc_CMP;
        //进入流水的数据
        wire [31:0] Data_D_final;
        wire [4:0]  ExcCode_D_final;

    // Execute ************************************************************************************
        //ALU
        wire [31:0] ALU_C;
        wire        isOverflow;
        //MDU
        wire [31:0] HI, LO;
        wire        E_Busy;
        //EXT
        wire [31:0] imm_E_final;
        //进入流水的数据
        wire [31:0] Data_E_final;
        wire [4:0]  ExcCode_E_final;

    // Memory *************************************************************************************
        //BE-WD
        wire [31:0] DM_WD;
        wire [3:0]  DM_Byteen;
        //BE_RD
        wire [31:0] DM_RD;
        //CP0
        wire [31:0] CP0_DOut;
        wire [31:0] EPC;
        wire        Req;
        //进入流水的数据
        wire [31:0] Data_M_final;
        wire [4:0]  ExcCode_M_final;

    // WB *****************************************************************************************
        /*无*/

    // HazardForward ******************************************************************************
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
        //中断
        wire [31:0] PC_F_temp;
        assign PC_F = 
            (isEret_D & ismtc0_E & (Rd_E==5'd14) )? RD2_E_final:
            (isEret_D & ismtc0_M & (Rd_M==5'd14) )? RD2_M_final:
            (isEret_D)?                             EPC:
                                                    PC_F_temp;
        wire [31:0] NPC_Truly;
        assign NPC_Truly = 
            (Req)?      32'h0000_4180:
            (isEret_D)? PC_F+32'd4:                                          
                        NPC;
        //PC
        PC u_PC(
            .clk   	( clk       ),
            .reset 	( reset     ),
            .en    	( (~stallPC) || Req || isEret_D ),

            .NPC   	( NPC_Truly ),
            .PC    	( PC_F_temp      )
        );
        
        //IM
        assign i_inst_addr = PC_F;
        assign IN_F = (ExcCode_F ==5'd4)? 32'd0 : i_inst_rdata;

        //Process Exception
        assign ExcCode_F = 
            (   (PC_F[1:0] != 2'b00) 
            ||  (PC_F < 32'h0000_3000) 
            ||  (PC_F > 32'h0000_6ffc))?    5'd4: 
                                            5'd0;
        
    // DEMW *****************************************************************************
        //ID
        DEMW ID(
            .clk       	( clk           ),
            .reset     	( reset ),
            .en        	( ~stallID  ),
            .Req        ( Req ),

            .INS       	( IN_F        ),
            .PC        	( PC_F         ),
            .BD         ( BD ),
            .ExcCode    ( ExcCode_F ),
            
            .INS_n     	( IN_D    ),
            .PC_n      	( PC_D     ),
            .BD_n       ( BD_D ),
            .ExcCode_n  ( ExcCode_D )
        );
        
        //EX
        EX EX(
            .clk       	( clk           ),
            .reset     	( reset ),
            .en        	( enEX         ),
            .flush      ( flushEX ),
            .Req        ( Req ),

            .INS       	( IN_D       ),
            .PC        	( PC_D         ),
            .A3        	( A3_D         ),
            .Tuse_Rs   	( Tuse_Rs_D    ),
            .Tuse_Rt   	( Tuse_Rt_D    ),
            .Tnew      	( Tnew_D       ),
            .RD1       	( RD1_D_final        ),
            .RD2       	( RD2_D_final        ),
            .Data      	( Data_D_final       ),
            .BD         ( BD_D ),
            .ExcCode    ( ExcCode_D_final ),
            
            .INS_n     	( IN_E      ),
            .PC_n      	( PC_E       ),
            .A3_n      	( A3_E       ),
            .Tuse_Rs_n 	( Tuse_Rs_E  ),
            .Tuse_Rt_n 	( Tuse_Rt_E  ),
            .Tnew_n    	( Tnew_E     ),
            .RD1_n     	( RD1_E      ),
            .RD2_n     	( RD2_E      ),
            .Data_n    	( Data_E     ),
            .BD_n       ( BD_E ),
            .ExcCode_n  ( ExcCode_E )
        );
        
        //MEM
        DEMW MEM(
            .clk       	( clk           ),
            .reset     	( reset || Req ),
            .en        	( enMEM         ),
            .Req        ( Req ),

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
            .BD         ( BD_E ),
            .ExcCode    (ExcCode_E_final),
            
            .INS_n     	( IN_M      ),
            .PC_n      	( PC_M       ),
            .A3_n      	( A3_M       ),
            .Tuse_Rs_n 	( Tuse_Rs_M  ),
            .Tuse_Rt_n 	( Tuse_Rt_M  ),
            .Tnew_n    	( Tnew_M     ),
            .RD1_n     	( RD1_M      ),
            .RD2_n     	( RD2_M      ),
            .Data_n    	( Data_M     ),
            .ALU_n      ( DM_A       ),
            .BD_n       ( BD_M ),
            .ExcCode_n  (ExcCode_M)
        );

        //WB
        DEMW WB(
            .clk       	( clk           ),
            .reset     	( reset  ),
            .en        	( enWB         ),
            .Req        ( Req ),

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
            .BD             ( BD ),
            .RI             ( RI ),
            .isSyscall      ( isSyscall ),
            .isEret_D       ( isEret_D ),
           
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
            .Ov_E           ( Ov_E ),
            .Ld_E           ( Ld_E ),
            .St_E           ( St_E ),
            .ismtc0_E       ( ismtc0_E ),
            
            .isRead_Rs     	( isRead_Rs_E      ),
            .isRead_Rt     	( isRead_Rt_E      )
        );
        
        // Controller-M
        Controller u_Controller_M(
            .ins           	( IN_M            ),
            
            .DM_WE_01      	( DM_WE_01       ),
            .DM_Width_02    ( DM_Width_02 ),
            .OutSelect_M   	( OutSelect_M    ),
            .Ld_M           ( Ld_M ),
            .St_M           ( St_M ),
            .CP0_WE         ( CP0_WE ),
            .isEret_M       ( isEret_M ),
            .ismtc0_M       ( ismtc0_M ),

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
            .A     	    ( RD1_E_final      ),
            .B     	    ( tmp_03      ),
            .ALUOp 	    ( ALU_Op_03  ),
            .C     	    ( ALU_C      ),
            .isOverflow ( isOverflow )
        );
        //MDU
        MDU u_MDU(
            .clk        (clk),
            .reset      (reset),
            .start      ((MDU_Start_01) & (!Req)),
            .A          (RD1_E_final),
            .B          (RD2_E_final),
            .MDU_Op     (MDU_Op_02),
            .HI_Write   ((MDU_HI_Write_03 & (!Req) )),
            .LO_Write   ((MDU_LO_Write_04 & (!Req) )),
            .HI         (HI),
            .LO         (LO),
            .busy       (E_Busy)
        );
        
    //Memory
        assign macroscopic_pc = PC_M;
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
        assign m_data_byteen    = 
            (Req)?  4'd0:
                    DM_Byteen;
        assign m_inst_addr      = PC_M;
        BE_RD u_BE_RD(
            .DM_RD          (m_data_rdata),
            .DM_A           (DM_A),
            .DM_Width_02    (DM_Width_02),

            .DM_RD_13       (DM_RD)
        );

        CP0 u_CP0(
            .clk                (clk),
            .reset              (reset),
            .CP0_Addr           (Rd_M),
            .CP0_Din            (RD2_M_final),
            .CP0_WE             (CP0_WE),
            .CP0_DOut           (CP0_DOut),
            .PC                 (PC_M),
            .BD                 (BD_M),
            .HWInt              (HWInt),
            .ExcCode            (ExcCode_M_final),
            .EXLClr             (isEret_M),
            .EPC                (EPC),
            .Req                (Req)
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
    /////////////////////////////// Data 送出本层或上一层 /////////////////////////////////
    // Decode
    assign Data_D_final = (OutSelect_D)?    (PC_D+32'h0000_0008) : 32'bz;
    // Execute
    assign Data_E_final = 
        (OutSelect_E==2'd3)?    LO: 
        (OutSelect_E==2'd2)?    HI: 
        (OutSelect_E==2'd1)?    ALU_C: 
                                Data_E;
    // Memory
    assign Data_M_final = 
        (OutSelect_M==2'd2)?    CP0_DOut: 
        (OutSelect_M==2'd1)?    DM_RD:
                                Data_M;

    ///////////////////////////// ExcCode 送出本层或上一层 ///////////////////////////////
    // Decode
    assign      ExcCode_D_final = (ExcCode_D == 5'd0)?  ExcCode_D_b : ExcCode_D;
    wire [4:0]  ExcCode_D_b;
    assign      ExcCode_D_b =
                (RI)?           5'd10:
                (isSyscall)?    5'd8:
                                5'd0;
    // Execute
    assign      ExcCode_E_final = (ExcCode_E == 5'd0)?  ExcCode_E_b : ExcCode_E;
    wire [4:0]  ExcCode_E_b;
    assign      ExcCode_E_b =
                (Ov_E & isOverflow)?    5'd12:
                (Ld_E & isOverflow)?    5'd4:
                (St_E & isOverflow)?    5'd5:
                                        5'd0;
    // Memory
    assign      ExcCode_M_final = (ExcCode_M == 5'd0)? ExcCode_M_b : ExcCode_M;
    wire [4:0]  ExcCode_M_b;
    assign      ExcCode_M_b =
                // lw + DM_A[1:0]不为00 
                // lh + DM_A[0]不为0 
                // lh|lb + DM_A在TC0|TC1
                // isLoad + DM_A不在DM,TC0,TC1,IntGenerator
                (Ld_M & (DM_Width_02 == 2'd0) & (DM_A[1:0] != 2'b00) )? 5'd4:
                (Ld_M & (DM_Width_02 == 2'd1) & (DM_A[0] != 1'b0) )?    5'd4:
                (Ld_M & (DM_Width_02 != 2'd0) & (withinTCS) )?          5'd4:
                (Ld_M & (~withinLegal) )?                               5'd4:
                // sw + DM_A[1:0]不为00 
                // sh + DM_A[0]不为0 
                // sh|sb + DM_A在TC0|TC1
                // isStore + DM_A在TC0|TC1 + DM_A[3:2]为2'b10
                // isStore + DM_A不在DM,TC0,TC1,IntGenerator
                (St_M & (DM_Width_02 == 2'd0) & (DM_A[1:0] != 2'b00) )? 5'd5:
                (St_M & (DM_Width_02 == 2'd1) & (DM_A[0] != 1'b0) )?    5'd5:
                (St_M & (DM_Width_02 != 2'd0) & (withinTCS) )?          5'd5:
                (St_M & (withinTCS) & (DM_A[3:2] == 2'b10) )?           5'd5:
                (St_M & (~withinLegal) )?                               5'd5:
                                                                        5'd0; 
    wire        withinLegal,    withinDM,   withinTCS,    withinIntGenerator;
    assign      withinLegal = (withinDM || withinTCS || withinIntGenerator);
    assign      withinDM    = (DM_A < 32'h0000_3000);
    assign      withinTCS   = ( ( (32'h0000_7f00 <= DM_A) & (DM_A <= 32'h0000_7f0b) )
                            ||  ( (32'h0000_7f10 <= DM_A) & (DM_A <= 32'h0000_7f1b) ) );
    assign      withinIntGenerator 
                            = ( (32'h0000_7f20 <= DM_A) & (DM_A <= 32'h0000_7f23) );
                            

endmodule
