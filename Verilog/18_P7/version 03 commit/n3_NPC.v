module NPC (
    input [31:0] PC_F,
    input [31:0] PC_D,

    input [31:0] rs,
    input [15:0] imm,
    input [25:0] ins_index,

    input isJr,
    input isJ,
    input isBranchSuccess,

    output [31:0] NPC
);

    assign NPC  =   (isJ)?                  {PC_D[31:28],   ins_index,  2'b00}:
                    (isBranchSuccess)?      PC_D + 4 + { {14{imm[15]}}, imm, 2'b00}:
                    (isJr)?                 rs:
                                            PC_F+4;

endmodule