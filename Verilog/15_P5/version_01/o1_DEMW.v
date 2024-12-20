module DEMW(
//三件套
    input clk,reset,en,
//INS,PC,PC4*******************
    input [31:0]    INS,
    input [31:0]    PC,
    input [31:0]    PC4,
//RD1,RD2**********************
    input [31:0]    RD1,
    input [31:0]    RD2,
//isStandbySuc*****************
    input           isStandbySuc,
//PC8,ALU,DM*******************
    input [31:0]    PC8,
    input [31:0]    ALU,
    input [31:0]    DM,
//standby**********************
    input [31:0]    standby,


//INS,PC,PC4*******************
    output reg [31:0]    INS_final,
    output reg [31:0]    PC_final,
    output reg [31:0]    PC4_final,
//RD1,RD2**********************
    output reg [31:0]    RD1_final,
    output reg [31:0]    RD2_final,
//isStandbySuc*****************
    output reg           isStandbySuc_final,
//PC8,ALU,DM*******************
    output reg [31:0]    PC8_final,
    output reg [31:0]    ALU_final,
    output reg [31:0]    DM_final,
//standby**********************
    output reg [31:0]    standby_final
);
    initial begin
        //INS,PC,PC4*******************
        INS_final       <=32'h0000_0000;
        PC_final        <=32'h0000_0000;
        PC4_final       <=32'h0000_0000;
        //RD1,RD2**********************
        RD1_final       <=32'h0000_0000;
        RD2_final       <=32'h0000_0000;
        //isStandbySuc*****************
        isStandbySuc_final       <=1'b0;
        //PC8,ALU,DM*******************
        PC8_final       <=32'h0000_0000;
        ALU_final       <=32'h0000_0000;
        DM_final        <=32'h0000_0000;
        //standby**********************
        standby_final   <=32'h0000_0000;
    end

    always @(posedge clk) begin
        if(reset)begin
            //INS,PC,PC4*******************
            INS_final       <=32'h0000_0000;
            PC_final        <=32'h0000_0000;
            PC4_final       <=32'h0000_0000;
            //RD1,RD2**********************
            RD1_final       <=32'h0000_0000;
            RD2_final       <=32'h0000_0000;
            //isStandbySuc*****************
            isStandbySuc_final       <=1'b0;
            //PC8,ALU,DM*******************
            PC8_final       <=32'h0000_0000;
            ALU_final       <=32'h0000_0000;
            DM_final        <=32'h0000_0000;
            //standby**********************
            standby_final   <=32'h0000_0000;
        end
        else if(en)begin
            //INS,PC,PC4*******************
            INS_final<=INS;
            PC_final<=PC;
            PC4_final<=PC4;
            //RD1,RD2**********************
            RD1_final<=RD1;
            RD2_final<=RD2;
            //isStandbySuc*****************
            isStandbySuc_final<=isStandbySuc;
            //PC8,ALU,DM*******************
            PC8_final<=PC8;
            ALU_final<=ALU;
            DM_final<=DM;
            //standby**********************
            standby_final<=standby;
        end
    end
    
endmodule //DEMW