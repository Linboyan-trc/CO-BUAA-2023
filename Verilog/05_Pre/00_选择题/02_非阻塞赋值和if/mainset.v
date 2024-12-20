module mainset(
    input clk,
    input reset,
    output reg b_my
);
    reg [3:0]a;
    always @(posedge clk) begin
        if(reset)begin
            a<=0;
            b_my<=0;
        end
        else begin
            a<=a+1;
            if(a==4)b_my<=1;
            else b_my<=0;
        end
    end
endmodule