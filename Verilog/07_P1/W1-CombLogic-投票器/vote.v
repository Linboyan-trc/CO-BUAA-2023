module voteMulti (
    input [31:0]np,
    input [7:0]vip,
    input vvip,
    output reg res
);
    integer i;
    reg [7:0]cnt;
    always @(*) begin
        cnt=0;
        for(i=0;i<32;i=i+1)begin
            if(np[i]==1)cnt=cnt+8'd1;
        end
        for(i=0;i<8;i=i+1)begin
            if(vip[i]==1)cnt=cnt+8'd4;
        end
        if(vvip==1)cnt=cnt+8'd16;
        if(cnt>=8'd32)begin
            res=1;
        end
        else begin
            res=0;
        end
    end

endmodule