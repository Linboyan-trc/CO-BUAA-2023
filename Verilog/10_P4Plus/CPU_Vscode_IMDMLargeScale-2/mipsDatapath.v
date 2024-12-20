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
    //连线声明,按照通路顺序,NPC->PC->Controller->GRF/ALU/DM
    //检查:1.";"结尾 2.Input和Output方向
        //NPC
            wire [31:0] NPCInput_PC;
            wire [31:0] NPCInput_rs;
            wire [15:0] NPCInput_imm;
            wire [25:0] NPCInput_ins_index;
            wire NPCInput_isJr;
            wire NPCInput_isBranch;
            wire NPCInput_isBranchSuccess;
            wire NPCInput_isJal;
            wire [31:0] NPCOutput_PC4;
            wire [31:0] NPCOutput_NPC;
        //PC
            // wire PCInput_clk;
            // wire PCInput_reset;
            wire [31:0] PCInput_NPC;
            wire [31:0] PCOutput_PC;
        //IM
            wire [31:0] IMInput_PC;
            wire [31:0] IMOutput_Ins;
        //Controller
            wire [31:0] ControllerInput_ins;
            wire ControllerOutput_GRF_WE_02;
            wire ControllerOutput_ALU_B_04,ControllerOutput_ALU_immExt_05;
            wire ControllerOutput_DM_WE_07;
            wire ControllerOutput_isJr_08,ControllerOutput_isBranch_09,ControllerOutput_isJal_10;
            wire [1:0] ControllerOutput_A3_RdRtRa_01;
            wire [1:0] ControllerOutput_GRF_WD_03;
            wire [2:0] ControllerOutput_ALU_Op_06;
            wire ControllerOutput_islb;
        //GRF
            // wire GRFInput_clk;
            // wire GRFInput_reset;
            wire [4:0] GRFInput_A1;
            wire [4:0] GRFInput_A2;
            wire [4:0] GRFInput_A3;
            wire [31:0] GRFInput_WD;
            wire [31:0] GRFInput_PC;
            wire GRFInput_WE;
            wire [31:0] GRFOutput_RD1;
            wire [31:0] GRFOutput_RD2;
        //EXT
            wire [15:0] EXTInput_imm;
            wire EXTInput_zeroOrSigned;
            wire [31:0] EXTOutput_immHasExted;
        //ALU
            wire [31:0] ALUInput_A;
            wire [31:0] ALUInput_B;
            wire [2:0] ALUInput_ALUOp;
            wire [31:0] ALUOutput_C;
            wire ALUOutput_isEqual;
        //DM
            // wire DMInput_clk;
            // wire DMInput_reset;
            wire [31:0] DMInput_A;
            wire [31:0] DMInput_WD;
            wire [31:0] DMInput_PC;
            wire  DMInput_WE;
            wire [31:0] DMOutput_RD;

    //模块连接到线
    //检查:1.u_换成my
            NPC myNPC(
                .PC              	( NPCInput_PC               ),
                .rs              	( NPCInput_rs               ),
                .imm             	( NPCInput_imm              ),
                .ins_index       	( NPCInput_ins_index        ),
                .isJr            	( NPCInput_isJr             ),
                .isBranch        	( NPCInput_isBranch         ),
                .isBranchSuccess 	( NPCInput_isBranchSuccess  ),
                .isJal           	( NPCInput_isJal            ),
                .PC4             	( NPCOutput_PC4              ),
                .NPC             	( NPCOutput_NPC              )
            );

            PC myPC(
                .clk   	( clk    ),
                .reset 	( reset  ),
                .NPC   	( PCInput_NPC    ),
                .PC    	( PCOutput_PC     )
            );

            IM myIM(
                .PC  	( IMInput_PC   ),
                .Ins 	( IMOutput_Ins  )
            );
            
            Controller myController(
                .ins           	( ControllerInput_ins            ),
                .GRF_WE_02     	( ControllerOutput_GRF_WE_02      ),
                .ALU_B_04      	( ControllerOutput_ALU_B_04       ),
                .ALU_immExt_05 	( ControllerOutput_ALU_immExt_05  ),
                .DM_WE_07      	( ControllerOutput_DM_WE_07       ),
                .isJr_08       	( ControllerOutput_isJr_08        ),
                .isBranch_09   	( ControllerOutput_isBranch_09    ),
                .isJal_10      	( ControllerOutput_isJal_10       ),
                .A3_RdRtRa_01  	( ControllerOutput_A3_RdRtRa_01   ),
                .GRF_WD_03     	( ControllerOutput_GRF_WD_03      ),
                .ALU_Op_06     	( ControllerOutput_ALU_Op_06      ),
                .islb           ( ControllerOutput_islb           )
            );

            GRF myGRF(
                .clk   	( clk    ),
                .reset 	( reset  ),
                .A1    	( GRFInput_A1     ),
                .A2    	( GRFInput_A2     ),
                .A3    	( GRFInput_A3     ),
                .WD    	( GRFInput_WD     ),
                .PC    	( GRFInput_PC     ),
                .WE    	( GRFInput_WE     ),
                .RD1   	( GRFOutput_RD1    ),
                .RD2   	( GRFOutput_RD2    )
            );

            EXT myEXT(
                .imm          	( EXTInput_imm           ),
                .zeroOrSigned 	( EXTInput_zeroOrSigned  ),
                .immHasExted  	( EXTOutput_immHasExted   )
            );
            
            ALU myALU(
                .A       	( ALUInput_A        ),
                .B       	( ALUInput_B        ),
                .ALUOp   	( ALUInput_ALUOp    ),
                .C       	( ALUOutput_C        ),
                .isEqual 	( ALUOutput_isEqual  )
            );

            DM myDM(
                .A     	( DMInput_A      ),
                .WD    	( DMInput_WD     ),
                .PC    	( DMInput_PC     ),
                .WE    	( DMInput_WE     ),
                .clk   	( clk    ),
                .reset 	( reset  ),
                .RD    	( DMOutput_RD     )
            );
        
    //线连接到线,这里只需要连接模块之间,clk和reset已经在上面模块声明连好了
        //ins拆分
        wire [5:0]op,func;
        wire [4:0]Rs,Rt,Rd,shamt;
        wire [15:0]imm;
        wire [25:0]ins_index;
        assign op=IMOutput_Ins[31:26];
        assign Rs=IMOutput_Ins[25:21];
        assign Rt=IMOutput_Ins[20:16];
        assign Rd=IMOutput_Ins[15:11];
        assign shamt=IMOutput_Ins[10:6];
        assign func=IMOutput_Ins[5:0];
        assign imm=IMOutput_Ins[15:0];
        assign ins_index=IMOutput_Ins[25:0];
        //NPC输入
            assign NPCInput_PC=PCOutput_PC;
            assign NPCInput_rs=GRFOutput_RD1;
            assign NPCInput_imm=imm;
            assign NPCInput_ins_index=ins_index;
            assign NPCInput_isJr=ControllerOutput_isJr_08;
            assign NPCInput_isBranch=ControllerOutput_isBranch_09;
            assign NPCInput_isBranchSuccess=ALUOutput_isEqual;
            assign NPCInput_isJal=ControllerOutput_isJal_10;
        //PC输入
            assign PCInput_NPC=NPCOutput_NPC;
        //IM输入
            assign IMInput_PC=PCOutput_PC;
        //Controller输入
            assign ControllerInput_ins=IMOutput_Ins;
        //GRF输入
            assign GRFInput_A1=Rs;
            assign GRFInput_A2=Rt;
            assign GRFInput_A3= (ControllerOutput_A3_RdRtRa_01==2'b00)?Rd:
                                (ControllerOutput_A3_RdRtRa_01==2'b01)?Rt:
                                (ControllerOutput_A3_RdRtRa_01==2'b10)?5'd31:
                                5'd0;

            //****
            wire [31:0]DMOutput_RDConsiderLb;
            wire [31:0]tempFirst;
            assign tempFirst = (ALUOutput_C[1:0]==2'b00)? { {24{DMOutput_RD[7]}}, DMOutput_RD[7:0]}:
                                (ALUOutput_C[1:0]==2'b01)? { {24{DMOutput_RD[15]}}, DMOutput_RD[15:8]}:
                                (ALUOutput_C[1:0]==2'b10)? { {24{DMOutput_RD[23]}}, DMOutput_RD[23:16]}:
                                { {24{DMOutput_RD[31]}}, DMOutput_RD[31:24]};
            assign DMOutput_RDConsiderLb = (ControllerOutput_islb)?tempFirst:DMOutput_RD;
            //****
            assign GRFInput_WD= (ControllerOutput_GRF_WD_03==2'b00)?ALUOutput_C:
                                (ControllerOutput_GRF_WD_03==2'b01)?DMOutput_RDConsiderLb:
                                (ControllerOutput_GRF_WD_03==2'b10)?NPCOutput_PC4:
                                32'd0;
            assign GRFInput_PC=PCOutput_PC;
            assign GRFInput_WE=ControllerOutput_GRF_WE_02;
        //EXT输入
            assign EXTInput_imm=imm;
            assign EXTInput_zeroOrSigned=ControllerOutput_ALU_immExt_05;
        //ALU输入
            assign ALUInput_A=GRFOutput_RD1;
            assign ALUInput_B=  (ControllerOutput_ALU_B_04==1'b0)?GRFOutput_RD2:
                                (ControllerOutput_ALU_B_04==1'b1)?EXTOutput_immHasExted:
                                32'd0;
            assign ALUInput_ALUOp=ControllerOutput_ALU_Op_06;
        //DM输入
            assign DMInput_PC=PCOutput_PC;
            assign DMInput_A=ALUOutput_C;
            assign DMInput_WD=GRFOutput_RD2;
            assign DMInput_WE=ControllerOutput_DM_WE_07;
endmodule
