module ext (
    input [15:0]imm,
    input [1:0]EOp,
    output [31:0]ext
);
    assign ext =    (EOp==2'd0)?{{16{imm[15]}},imm}:
                    (EOp==2'd1)?{{16{1'b0}},imm}:
                    (EOp==2'd2)?{imm,{16{1'b0}}}:
                    {{14{imm[15]}},imm,{2{1'b0}}};
endmodule