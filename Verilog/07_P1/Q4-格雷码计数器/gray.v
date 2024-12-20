module gray (
    input Clk,Reset,En,
    output [2:0]Output,
    output reg Overflow
);
    reg [2:0]cnt;
    assign Output[0]=cnt[0]^cnt[1];
    assign Output[1]=cnt[1]^cnt[2];
    assign Output[2]=cnt[2];
    initial begin
        cnt<=3'd0;
        Overflow<=1'd0;
    end
    always @(posedge Clk) begin
        if(Reset)begin
            cnt<=3'd0;
            Overflow=1'd0;
        end
        else begin
            if(En)begin
                cnt<=cnt+1'b1;
                if(cnt==3'd7)Overflow<=1'b1;
            end
        end
    end
endmodule //gray
