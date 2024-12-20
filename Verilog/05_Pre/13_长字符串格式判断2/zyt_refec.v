`timescale 1ns / 1ps

module cpu_checker(
    input  clk,
    input reset,
    input [7:0] char,
    output [1:0] format_type
    );

reg [3:0] status = 4'b0;
reg [1:0] reg10 = 2'b0;
reg [2:0] reg16 = 3'b0;
reg flag = 1'b0;

assign format_type = (status != 4'd14) ? 2'b00 : 
                     (flag == 1'b0) ? 2'b01 :
                     2'b10;

always @(posedge clk) begin
    if(reset == 1'b1) begin
        status <= 4'b0;
        reg10 <= 2'b0;
        reg16 <= 3'b0;
        flag <= 1'b0;
    end
    else begin
        case(status)
            4'd0:begin
                if(char == "^")begin
                    status <= 4'd1;
                end
                else begin
                    status <= 4'b0;
                end
            end
            4'd1:begin
                if(char == "^") begin
                    status <= 4'd1;
                end
                else if(char >= "0" && char <= "9")begin
                    status <= 4'd2;
                    reg10 <= 2'd1;
                end
                else begin
                    status <= 4'd0;
                end
            end
            4'd2:begin
                if(char == "@") status <= 4'd3;
                else if(char >= "0" && char <= "9")begin
                    reg10 <=reg10 + 2'd1;
                    if(reg10 == 2'd0) status <= 4'd0;
                    else status <= 4'd2;
                end
                else if (char == "^") status<= 4'd1;
                else status <= 4'd0;
            end
            4'd3:begin
                if(char == "^") status <= 4'd1;
                else if(char >= "0" && char <= "9"||char >= "a" && char <= "f")begin
                    reg16 <= 3'd1;
                    status <= 4'd4;
                end
                else status <= 4'd0;
            end
            4'd4:begin
                if(char == ":")begin
                    if(reg16 == 3'd0) status <= 4'd5;
                    else status <= 4'd0;
                end
                else if(char >= "0" && char <= "9"||char >= "a" && char <= "f")begin
                    reg16 <= reg16+3'd1;
                    if(reg16 == 3'b000) status<=4'd0;
                    else status<= 4'd4; 
                end
                else if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            4'd5:begin
                if(char == " ") status <= 4'd5;
                else if(char == "^") status <= 4'd1;
                else if(char == "$") begin
                    flag <= 1'b0;
                    status <= 4'd6;
                end
                else if(char == "*")begin
                    flag <= 1'b1;
                    status <= 4'd7;
                end
                else status <= 4'd0;
            end
            4'd6:begin
                if(char >= "0" && char <= "9")begin
                    reg10 <= 2'd1;
                    status <= 4'd8;
                end
                else if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            4'd7: begin
                if(char >= "0" && char <= "9"||char >= "a" && char <= "f")begin
                    reg16 <= 3'd1;
                    status <= 4'd9;
                end
                else if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            4'd8: begin
                if(char >= "0" && char <= "9") begin
                    reg10 <= reg10 + 2'd1;
                    if(reg10 == 2'd0) status <= 4'd0;
                    else status <= 4'd8;
                end
                else if(char == " ") status <= 4'd10;
                else if(char == "<") status <= 4'd11;
                else if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            4'd9 : begin
                if(char >= "0" && char <= "9"||char >= "a" && char <= "f")begin
                    reg16 <= reg16 + 3'd1;
                    if(reg16 == 3'b000) status <= 4'd0;
                    else status <= 4'd9;
                end
                else if(char == "^") status <= 4'd1;
                else if(char == " ") begin
                    if(reg16 == 3'd0) begin
                        status <= 4'd10;
                    end
                    else status <=4'd0;
                end
                else if(char == "<") begin
                    if(reg16 == 3'd0) begin
                        status <= 4'd11;
                    end
                    else status <=4'd0;
                end
                else status <=  4'd0;
            end
            4'd10: begin
                if (char == " ") status <= 4'd10;
                else if(char == "^") status <= 4'd1;
                else if(char == "<") status <= 4'd11;
                else status <= 4'd0;
            end
            4'd11: begin
                if(char == "=") status <= 4'd12;
                else if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            4'd12: begin
                if(char == " ") status <= 4'd12;
                else if(char == "^") status <= 4'd1;
                else if(char >= "0" && char <= "9"||char >= "a" && char <= "f") begin
                    reg16 <= 3'd1;
                    status <= 4'd13;    
                end    
                else status <= 4'd0;
            end
            4'd13:begin
                if(char >= "0" && char <= "9"||char >= "a" && char <= "f") begin
                    reg16 <= reg16 +3'd1;
                    if(reg16 == 3'd0) status <= 4'd0;
                    else status <= 4'd13;
                end
                else if(char == "^") status <= 4'd1;
                else if(char == "#") begin
                    if(reg16 == 3'd0) status <= 4'd14;
                    else status <= 4'd0;
                end
                else status <= 4'd0;
            end
            4'd14:begin
                if(char == "^") status <= 4'd1;
                else status <= 4'd0;
            end
            default:  status <= 4'd0;
            
        endcase
    end
end
endmodule
