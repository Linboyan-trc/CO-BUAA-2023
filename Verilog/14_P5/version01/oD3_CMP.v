module CMP(
    input [31:0] C1,
    input [31:0] C2,
    output isEqual
);

	assign isEqual  =   (C1==C2) ? 1'b1 : 
                        1'b0;
	
endmodule