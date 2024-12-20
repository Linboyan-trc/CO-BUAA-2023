// `include "./mipsDatapath.v"
module mips(
    input clk,
    input reset
);
    mipsDatapath myMipsDatapath(
        .clk   	( clk    ),
        .reset 	( reset  )
    );
endmodule
