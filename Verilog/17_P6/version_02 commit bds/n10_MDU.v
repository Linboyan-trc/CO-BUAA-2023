module MDU(
    input           clk,reset,start,

    input [31:0]    A,
    input [31:0]    B,
    input [2:0]     MDU_Op, 
    input           HI_Write,
    input           LO_Write,

    output reg [31:0]   HI,
    output reg [31:0]   LO,
    output reg busy
);
    reg [31:0]  HI_temp;
    reg [31:0]  LO_temp;
    reg [3:0]   cnt;

    initial begin
        HI      <= 32'd0;
        LO      <= 32'd0;
        HI_temp <= 32'd0;
        LO_temp <= 32'd0;
        cnt     <= 4'd0;
        busy    <= 1'b0;
    end

    wire isABiggerThanB;
    assign isABiggerThanB = A > B ;

    always @(posedge clk) begin
        if(reset)begin
            HI      <= 32'd0;
            LO      <= 32'd0;
            HI_temp <= 32'd0;
            LO_temp <= 32'd0;
            cnt     <= 4'd0;
            busy    <= 1'b0;
        end
        else if(start) begin
            ///////////// mult or div, and set busy to 1 /////////////
            case (MDU_Op)
                3'd4:begin
                    if(isABiggerThanB)begin
                        if(B!=32'd0)begin
                            LO_temp <= A / B;
                            HI_temp <= A % B;
                            cnt <= 10;
                        end 
                        else begin
                            LO_temp <= LO;
                            HI_temp <= HI;
                            cnt <= 10;
                        end
                    end
                    else begin
                        if(A!=32'd0)begin
                            LO_temp <= B / A;
                            HI_temp <= B % A;
                            cnt <= 10;
                        end 
                        else begin
                            LO_temp <= LO;
                            HI_temp <= HI;
                            cnt <= 10;
                        end
                    end
                end
                3'd3: begin
                    //// 3-divu ////
                    if(B!=32'd0)begin
                        LO_temp <= A / B;
                        HI_temp <= A % B;
                        cnt <= 10;
                    end 
                    else begin
                        LO_temp <= LO;
                        HI_temp <= HI;
                        cnt <= 10;
                    end
                end
                3'd2: begin
                    //// 2-div ////
                    if(B!=32'd0)begin
                        LO_temp <= $signed(A) / $signed(B);
                        HI_temp <= $signed(A) % $signed(B);
                        cnt <= 10;
                    end
                    else begin
                        LO_temp <= LO;
                        HI_temp <= HI;
                        cnt <= 10;
                    end
                end
                3'd1: begin
                    //// 1-multu ////
                    {HI_temp, LO_temp} <= A * B;
					cnt <= 5;
                end
                3'd0: begin
                    //// 0-mult //// 
                    {HI_temp, LO_temp} <= $signed(A) * $signed(B);
					cnt <= 5;  
                end
            endcase
            busy <= 1'b1;
        end
        else if(HI_Write)begin
            HI <= A;
        end
        else if(LO_Write)begin
            LO <= A;
        end
        else if( (cnt!=4'd1) & (cnt!=4'd0) )begin
            cnt <= cnt-1;
        end
        else if(cnt==4'd1)begin
            //////// when cnt change from 1 to 0, this branch work ////////
            ///////////// transfer result, and set busy to 0 /////////////
            cnt <= cnt - 4'd1;
            busy <= 1'b0;
            HI <= HI_temp;
            LO <= LO_temp;
            // $display("%h %h", HI_temp,LO_temp);
        end
    end
    
endmodule //MD
