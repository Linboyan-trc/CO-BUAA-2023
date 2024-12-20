module fsm1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
//状态寄存器
	reg [1:0]nowState,nextState;
	initial begin
		nowState<=2'd0;
		nextState<=2'd0;
	end
//状态寄存
	always @(posedge clk,negedge rst)begin
		if(!rst)begin
			nowState<=2'd0;
			nextState<=2'd0;
		end
		else begin
			nowState<=nextState;
		end
	end
//下一状态计算
	always @(*)begin
		case (nowState)
			2'd0:begin
				nextState=data?2'd1:2'd0;
			end
			2'd1:begin
				nextState=data?2'd2:2'd1;
			end
			2'd2:begin
				nextState=data?2'd3:2'd2;
			end
			2'd3:begin
				nextState=data?2'd0:2'd3;
			end
		endcase
	end
//输出计算-非mealy
	always @(posedge clk,negedge rst)begin
		if(!rst)begin
			flag<=1'b0;
		end
		else begin
			if((nowState==2'd3)&&(data==1))begin
				flag<=1'b1;
			end
			else begin
				flag<=1'b0;
			end
		end
	end
//*************code***********//
endmodule