module ID(
    input clk,
    input reset,
    input en,

    input [31:0]INS_F,
    input [31:0]PC_F,

    output reg [31:0]INS_D,
    output reg [31:0]PC_D,
    output reg [31:0]PC4_D,
    output reg [31:0]PC8_D
);
    initial begin
        INS_D<=32'd0;
        PC_D<=32'd0;
        PC4_D<=32'd0;
        PC8_D<=32'd0;
    end

    always @(posedge clk) begin
        if(reset)begin
            INS_D<=32'd0;
            PC_D<=32'd0;
            PC4_D<=32'd0;
            PC8_D<=32'd0;
        end
        else if(en)begin
            INS_D<=INS_F;
            PC_D<=PC_F;
            PC4_D<=(PC_F+4);
            PC8_D<=(PC_F+8);
        end
    end
endmodule //ID
