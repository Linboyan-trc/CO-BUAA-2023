module ID(
	input clk,
	input reset,
	input en,

    input [31:0] Ins_F,
	input [31:0] PC_F,

	output reg[31:0] Ins_D,
	output reg[31:0] PC_D,
    output reg[31:0] PC4_D,
    output reg[31:0] PC8_D
);

	initial begin
		Ins_D <= 32'd0;
	end
	
	always@(posedge clk) begin
		if(reset) begin
			Ins_D <= 32'd0;
		end
		else if(en) begin
			Ins_D <= Ins_F;
			PC_D <= PC_F;
			PC4_D <= PC_F+4;
			PC8_D <= PC_F+8;
		end
        else begin
            Ins_D <= Ins_D;
			PC_D <= PC_D;
			PC4_D <= PC4_D;
			PC8_D <= PC8_D;
        end
	end
endmodule
