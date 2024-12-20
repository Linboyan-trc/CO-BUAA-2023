iverilog -o test.vvp tb.v mips.v mipsDatapath.v n1_IM.v n2_PC.v n3_NPC.v n4_GRF.v n5_ALU.v n6_DM.v n7_EXT.v n8_Controller.v n9_CMP.v n10_Hazard.v n11_Forward.v n12_InsJudge.v o1_ID.v o2_EX.v o3_MEM.v o4_WB.v
vvp test.vvp

