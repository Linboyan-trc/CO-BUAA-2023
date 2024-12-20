module BE_RD(
    input [31:0]    DM_RD,
    input [31:0]    DM_A,
    input [1:0]     DM_Width_02,

    output reg [31:0]   DM_RD_13
);

    always @(*) begin
        case (DM_Width_02)
            ////////////////////////////// byte ///////////////////////////
            2'd2: begin
                case (DM_A[1:0])        
                    2'b00: begin
                        DM_RD_13 = {{24{DM_RD[7]}},DM_RD[7:0]};
                    end
                    2'b01:begin
                        DM_RD_13 = {{24{DM_RD[15]}},DM_RD[15:8]};
                    end
                    2'b10:begin
                        DM_RD_13 = {{24{DM_RD[23]}},DM_RD[23:16]};
                    end
                    2'b11:begin
                        DM_RD_13 = {{24{DM_RD[31]}},DM_RD[31:24]};
                    end
                endcase
            end
            ////////////////////////////// half ///////////////////////////
            2'd1:begin
                case (DM_A[1])
                    1'b0: begin
                        DM_RD_13 = {{16{DM_RD[15]}},DM_RD[15:0]};
                    end
                    1'b1: begin
                        DM_RD_13 = {{16{DM_RD[31]}},DM_RD[31:16]};
                    end
                endcase
            end
            ////////////////////////////// word ///////////////////////////
            2'd0:begin
                        DM_RD_13 = DM_RD;
            end
        endcase
    end
    
endmodule //BE_RD
