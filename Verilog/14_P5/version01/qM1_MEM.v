module MEM(
    input clk,
    input reset,
    input en,

    input [31:0] Ins_E,
	input [31:0] PC_E,
    input [31:0] PC4_E,
    input [31:0] PC8_E,

    input [31:0] ALU_E,
    input [31:0] Store_Rt_E,

    input [1:0]GRF_1_A3_RdRtRa_E;
    input GRF_2_WE_E;
    //DM
    input DM_WE_E,


    output reg[31:0] Ins_M,
	output reg[31:0] PC_M,
    output reg[31:0] PC4_M,
    output reg[31:0] PC8_M,

    output reg[31:0] ALU_M,
    output reg[31:0] Store_Rt_M,

    output reg [1:0]GRF_1_A3_RdRtRa_M, 
    output reg      GRF_2_WE_M, 
    //DM
    output reg DM_WE_M
);

	initial begin
		Ins_M <= 0;
	end

	always@(posedge clk) begin
		if(reset) begin
			Ins_M <= 32'h00000000;
		end
		else if(en) begin
			Ins_M   <= Ins_E;
			PC_M    <= PC_E;
			PC4_M   <= PC4_E;
			PC8_M   <= PC8_E;
			ALU_M   <= ALU_E;
			Store_Rt_M <= Store_Rt_E;

            GRF_1_A3_RdRtRa_M <= GRF_1_A3_RdRtRa_E;
            GRF_2_WE_M <= GRF_2_WE_E;
            //DM
            DM_WE_M <+ DM_WE_E;
		end
	end
	
endmodule
