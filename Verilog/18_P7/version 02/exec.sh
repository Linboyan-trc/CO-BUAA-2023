iverilog -o test.vvp mips.v n10_MDU.v n2_PC.v n3_NPC.v n4_GRF.v n5_ALU.v n6_BE-1-WD.v n6_BE-2-RD.v n7_EXT.v n8_Controller.v n9_CMP.v o1_DEMW.v o2_Hazard.v o3_Forward.v o4_CP0.v p1_CPU.v p2_Bridge.v p3_TC.v tb-interrupt.v 
vvp test.vvp


