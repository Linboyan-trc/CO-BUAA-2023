module coloring (
    input clk,rst_n,
    input [1:0]color,
    output reg check
);
    
    //state
    reg [3:0]mySnow,mySnex;
    initial begin
        mySnow<=0;
        mySnex<=0;
    end

    //cnt
    reg [1:0]cnt_red;
	reg [1:0]cnt_gre;
	reg [1:0]cnt_blu;
	initial begin
		cnt_red<=0;
		cnt_gre<=0;
		cnt_blu<=0;
	end

    always @(posedge clk,negedge rst_n) begin
        if(rst_n==0)begin
            mySnow<=0;
        end
        else begin
            mySnow<=mySnex;
        end
    end

    always @(posedge clk,negedge rst_n) begin
        if(rst_n==0)begin
            mySnow<=0;
            mySnex<=0;
            check<=0;
        end
        else begin
            case (mySnex)
                4'd0:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd1;
                            check<=0;
                        end
                        2'd1: begin
                            mySnex<=4'd2;
                            check<=0;
                        end
                        2'd2: begin
                            mySnex<=4'd3;
                            check<=0;
                        end
                    endcase
                end 
                4'd1:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd4;
                            check<=0;
                        end
                        2'd1: begin
                            mySnex<=4'd1;
                            check<=1;
                        end
                        2'd2: begin
                            mySnex<=4'd3;
                            check<=0;
                        end
                    endcase
                end 
                4'd2:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd2;
                            check<=1;
                        end
                        2'd1: begin
                            mySnex<=4'd5;
                            check<=0;
                        end
                        2'd2: begin
                            mySnex<=4'd3;
                            check<=0;
                        end
                    endcase
                end 
                4'd3:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd1;
                            check<=0;
                        end
                        2'd1: begin
                            mySnex<=4'd2;
                            check<=0;
                        end
                        2'd2: begin
                            mySnex<=4'd6;
                            check<=0;
                        end
                    endcase
                end 
                4'd4:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd4;
                            check<=1;
                        end
                        2'd1: begin
                            mySnex<=4'd4;
                            check<=1;
                        end
                        2'd2: begin
                            mySnex<=4'd3;
                            check<=0;
                        end
                    endcase
                end 
                4'd5:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd5;
                            check<=1;
                        end
                        2'd1: begin
                            mySnex<=4'd5;
                            check<=1;
                        end
                        2'd2: begin
                            mySnex<=4'd3;
                            check<=0;
                        end
                    endcase
                end 
                4'd6:begin
                    case (color)
                        2'd0: begin
                            mySnex<=4'd1;
                            check<=0;
                        end
                        2'd1: begin
                            mySnex<=4'd2;
                            check<=0;
                        end
                        2'd2: begin
                            mySnex<=4'd6;
                            check<=1;
                        end
                    endcase
                end 
            endcase
        end
    end
endmodule