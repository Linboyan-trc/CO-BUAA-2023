module WB(
    input clk,
    input reset,
    input en,

    input [31:0] Ins_M,
	input [31:0] PC_M,
    input [31:0] PC4_M,
    input [31:0] PC8_M,
    input [31:0] ALU_M,
    input [31:0] DM_M,

    input [1:0] GRF_1_A3_RdRtRa_M,
    input [1:0] GRF_2_WE_M,

    output reg[31:0] Ins_W,
	output reg[31:0] PC_W,
    output reg[31:0] PC4_W,
    output reg[31:0] PC8_W,
    output reg[31:0] ALU_W,
    output reg[31:0] DM_W,

    output reg [1:0] GRF_1_A3_RdRtRa_W,
    output reg       GRF_2_WE_W, 
);
	initial begin
		Ins_W <= 32'd0;
	end

	always@(posedge clk) begin
		if(reset) begin
			Ins_W <= 32'h00000000;
		end
		else if(en) begin
			Ins_W <= Ins_M;
			PC_W <= PC_M;
			PC4_W <= PC4_M;
			PC8_W <= PC8_M;
			ALU_W <= ALU_M;
			DM_W <= DM_M;

            GRF_1_A3_RdRtRa_W <= GRF_1_A3_RdRtRa_M;
            GRF_2_WE_W <= GRF_2_WE_M;
		end
	end
	
endmodule