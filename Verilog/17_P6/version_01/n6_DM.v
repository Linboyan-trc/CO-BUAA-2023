module DM(
    input [31:0] A,WD,PC_M,
    input WE,
    input [1:0] Width,
    input LoadSign,

    input clk,reset,
    
    output reg [31:0] RD
);
    //RAM+初始化
    reg [31:0]DMdeRAM[0:3071];
    integer i;
    initial begin
        for(i=0;i<3072;i=i+1)begin
            DMdeRAM[i]<=32'h0000_0000;
        end
    end

    //写入
    always @(posedge clk) begin
        if (reset) begin
            for(i=0;i<3072;i=i+1)begin
                DMdeRAM[i]<=32'h0000_0000;
            end
        end
        else if(WE)begin
            // sw 直接写入
            // sh 根据A[1] 把WD[15:0] 写入高位/低位
            // sb 根据A[1:0] 把WD[7:0] 写入四种位置之一
            // DMdeRAM[A[13:2]]<=WD;
            // $display("%d@%h: *%h <= %h", $time,PC_M, A, WD);
            case (Width)
                2'd0: begin
                    ///////////////////// sw ///////////////////////
                    DMdeRAM[A[13:2]] = WD;
                    //$display("@%h: *%h <= %h", PC_M, A, WD);                   
                end
                2'd1: begin
                    ///////////////////// sh ///////////////////////
                    case (A[1])
                        1'd0: DMdeRAM[A[13:2]]  [15:0]  = WD[15:0];
                        1'd1: DMdeRAM[A[13:2]]  [31:16] = WD[15:0];
                    endcase
                    //$display("@%h: *%h <= %h", PC_M, {A[31:2],2'd0}, DMdeRAM[A[13:2]]);            
                end
                2'd2: begin
                    ///////////////////// sb ///////////////////////
                    case (A[1:0])
                        2'd0: DMdeRAM[A[13:2]]  [7:0]   =  WD[7:0];
                        2'd1: DMdeRAM[A[13:2]]  [15:8]  =  WD[7:0];
                        2'd2: DMdeRAM[A[13:2]]  [23:16] =  WD[7:0];
                        2'd3: DMdeRAM[A[13:2]]  [31:24] =  WD[7:0];
                    endcase
                    //$display("@%h: *%h <= %h", PC_M, {A[31:2],2'd0}, DMdeRAM[A[13:2]]); 
                end 
            endcase
        end
    end

    //读出
    // assign RD = DMdeRAM[A[13:2]];
    always @(*) begin
        case (Width)
            2'd0: begin
                ///////////////////// lw ///////////////////////
                RD = DMdeRAM[A[13:2]];
            end
            2'd1:begin
                ///////////////////// lh ///////////////////////
                case (A[1])
                    1'd0: RD[15:0] = DMdeRAM[A[13:2]]   [15:0];
                    1'd1: RD[15:0] = DMdeRAM[A[13:2]]   [31:16];
                endcase
                case (LoadSign)
                    0:    RD[31:16] = 16'd0;
                    1:    RD[31:16] = {16{RD[15]}};
                endcase
            end
            2'd2:begin
                ///////////////////// lb ///////////////////////
                case (A[1:0])
                    2'd0: RD[7:0] = DMdeRAM[A[13:2]]    [7:0];
                    2'd1: RD[7:0] = DMdeRAM[A[13:2]]    [15:8];
                    2'd2: RD[7:0] = DMdeRAM[A[13:2]]    [23:16];
                    2'd3: RD[7:0] = DMdeRAM[A[13:2]]    [31:24];
                endcase
                case (LoadSign)
                    0:    RD[31:8] = 24'd0;
                    1:    RD[31:8] = {24{RD[7]}};
                endcase
            end
            default:begin
                RD = 32'bz;
            end
        endcase
    end
endmodule
