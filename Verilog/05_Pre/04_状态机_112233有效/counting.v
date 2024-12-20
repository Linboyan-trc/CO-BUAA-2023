//输入：num clk 输出：ans
//4个状态
`define S_00 2'b00
`define S_01 2'b01
`define S_02 2'b10
`define S_03 2'b11
//模块
module counting (
        input [1:0]num,
        input clk,
        output ans
    );
    //初始化状态
    reg [1:0]status;
    initial
        status<=`S_00;
    //根据状态和num状态转移
    always@(posedge clk) begin
        case (status)
            `S_00: begin
                case (num)
                    2'b01:
                        status<=`S_01;
                    2'b10:
                        status<=`S_00;
                    2'b11:
                        status<=`S_00;
                    default:
                        status<=`S_00;
                endcase
            end
            `S_01: begin
                case (num)
                    2'b01:
                        status<=`S_01;
                    2'b10:
                        status<=`S_02;
                    2'b11:
                        status<=`S_00;
                    default:
                        status<=`S_00;
                endcase
            end
            `S_02: begin
                case (num)
                    2'b01:
                        status<=`S_01;
                    2'b10:
                        status<=`S_02;
                    2'b11:
                        status<=`S_03;
                    default:
                        status<=`S_00;
                endcase
            end
            `S_03: begin
                case (num)
                    2'b01:
                        status<=`S_01;
                    2'b10:
                        status<=`S_00;
                    2'b11:
                        status<=`S_03;
                    default:
                        status<=`S_00;
                endcase
            end
        endcase
    end
    //输出ans
    assign ans=(status==`S_03)?1'b1:1'b0;
endmodule
//
//
//
//
//
//
//
