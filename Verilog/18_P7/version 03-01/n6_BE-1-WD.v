module BE_WD(
    input [31:0]    RD2_M_final,
    input [31:0]    DM_A,
    input           DM_WE_01,
    input [1:0]     DM_Width_02,

    output reg [31:0]   DM_WD_11,
    output reg [3:0]    DM_Byteen_12
);

    always @(*) begin
        if (DM_WE_01) begin
            case (DM_Width_02)
                ///////////////////////////// byte /////////////////////////////
                2'd2: begin
                    case (DM_A[1:0])
                        2'b00:begin
                            DM_WD_11        = {24'd0,RD2_M_final[7:0]};
                            DM_Byteen_12    = 4'b0001;
                        end 
                        2'b01:begin
                            DM_WD_11        = {16'd0,RD2_M_final[7:0],8'd0};
                            DM_Byteen_12    = 4'b0010;
                        end
                        2'b10:begin
                            DM_WD_11        = {8'd0,RD2_M_final[7:0],16'd0};
                            DM_Byteen_12    = 4'b0100;
                        end
                        2'b11:begin
                            DM_WD_11        = {RD2_M_final[7:0],24'd0};
                            DM_Byteen_12    = 4'b1000;
                        end
                    endcase
                end
                ///////////////////////////// half /////////////////////////////
                2'd1:begin
                    case (DM_A[1])
                        1'b0: begin
                            DM_WD_11        = {16'd0,RD2_M_final[15:0]};
                            DM_Byteen_12    = 4'b0011;
                        end 
                        1'b1:begin
                            DM_WD_11        = {RD2_M_final[15:0],16'd0};
                            DM_Byteen_12    = 4'b1100;
                        end
                    endcase
                end
                ///////////////////////////// word /////////////////////////////
                2'd0:begin
                            DM_WD_11        = RD2_M_final;
                            DM_Byteen_12    = 4'b1111;
                end
            endcase
        end
        else begin
            DM_WD_11    = 32'd0;
            DM_Byteen_12= 4'b0000;
        end
    end

    
endmodule //BE
