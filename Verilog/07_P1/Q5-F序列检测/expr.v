module expr (
    input clk,clr,
    input [7:0]in,
    output out
);
    reg [1:0]my_state;
    initial begin
        my_state<=2'd0;
    end
    //状转
    always @(posedge clk,clr) begin
        if(clr)begin
            my_state<=2'd0;
        end
        else if(clk) begin
            case (my_state)
                2'd0:begin
                    if((in>="0")&&(in<="9"))begin
                        my_state<=2'd1;
                    end
                    else begin
                        my_state<=2'd3;
                    end
                end 
                2'd1:begin
                    if((in=="+")||(in=="*"))begin
                        my_state<=2'd2;
                    end
                    else begin
                        my_state<=2'd3;
                    end
                end
                2'd2:begin
                    if((in>="0")&&(in<="9"))begin
                        my_state<=2'd1;
                    end
                    else begin
                        my_state<=2'd3;
                    end
                end
                2'd3:begin
                    my_state<=2'd3;
                end
            endcase
        end
    end
    //根据当前状态输出
    assign out = (my_state==2'd1)?1:
                    0;
endmodule