iverilog -o test.vvp tb.v mips.v mipsDatapath.v n1_IM.v n2_PC.v n3_NPC.v n4_GRF.v n5_ALU.v n6_DM.v n7_EXT.v n8_Controller.v n9_CMP.v o1_DEMW.v o2_Hazard.v o3_ForwardUnit.v
vvp test.vvp