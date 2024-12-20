module EX(
    input clk,
    input reset,
    input en,

    input [31:0] Ins_D,
	input [31:0] PC_D,
    input [31:0] PC4_D,
    input [31:0] PC8_D,

    input [31:0] Rs_D,
    input [31:0] Rt_D,
    input [31:0] EXT_D,

    //GRF
    input [1:0]GRF_1_A3_RdRtRa_D,
    input      GRF_2_WE_D,
    //ALU
    input   ALU_1_B_D,
    input   ALU_2_EXT_D,
    input   [2:0]ALU_3_Op_D,
    //DM
    input DM_WE_D,

    output reg [31:0] Ins_E,
	output reg [31:0] PC_E,
    output reg [31:0] PC4_E,
    output reg [31:0] PC8_E,

    output reg [31:0] Rs_E,
    output reg [31:0] Rt_E,
    output reg [31:0] EXT_E,

    //GRF
    output reg[1:0]GRF_1_A3_RdRtRa_E,
    output reg     GRF_2_WE_E,
    //ALU
    output reg  ALU_1_B_E,
    output reg  ALU_2_EXT_E,
    output reg [2:0]ALU_3_Op_E,
    //DM
    output DM_WE_E
);
	
	initial begin
		Ins_E <= 0;
	end
	
	always@(posedge clk) begin
		if(reset) begin
			Ins_E <= 32'h00000000;
		end
		else if(en) begin
			Ins_E <= Ins_D;
			PC_E <= PC_D;
			PC4_E <= PC4_D;
			PC8_E <= PC8_D;
			Rs_E <= Rs_D;
			Rt_E <= Rt_D;
			EXT_E <= EXT_D;

            GRF_1_A3_RdRtRa_E <= GRF_1_A3_RdRtRa_D;
            GRF_2_WE_E <= GRF_2_WE_D;
            ALU_1_B_E <= ALU_1_B_D;
            ALU_2_EXT_E <= ALU_2_EXT_D;
            ALU_3_Op_E <= ALU_3_Op_D;
            DM_WE_E <= DM_WE_D;
		end
	end
	
endmodule
