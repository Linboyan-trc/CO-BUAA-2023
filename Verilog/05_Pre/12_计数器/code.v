//输入:reset slt选择 en clk
//输出：output0和1，就是计数用的 位宽64
module code (
        input Clk,Reset,Slt,En,
        output reg [63:0]Output0,Output1
    );
    //Output1有四种状态，只有状态4可以+1
    reg [1:0]status1;
    initial status1=2'b00;
    //根据reset和enable，有四种情况，其中10和11当做default来处理
    always@(posedge Clk) begin
        case ({Reset,En})
            2'b00:
                ;
            2'b01: begin
                if(Slt==1'b1)
                    case (status1)
                        2'b00:  status1<=2'b01;
                        2'b01:  status1<=2'b10;
                        2'b10:  status1<=2'b11;
                        2'b11:  begin
                            status1<=2'b00;
                            Output1<=Output1+1;
                        end
                    endcase
                else
                    Output0<=Output0+1;
            end
            default: begin
                Output0<=0;
                Output1<=0;
            end
        endcase
    end
endmodule
