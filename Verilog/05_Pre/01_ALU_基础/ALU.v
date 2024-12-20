module ALU (
    input [3:0]inA,inB,
    input [1:0]op,
    output [3:0]ans
);
    assign ans =    (op==2'b00)?inA&inB:
                    (op==2'b01)?inA|inB:
                    (op==2'b10)?inA^inB:
                    (op==2'b11)?inA+inB:
                    4'b0000;
endmodule