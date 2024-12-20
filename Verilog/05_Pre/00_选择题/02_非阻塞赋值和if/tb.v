module tb ( 
);
    reg clk;
    reg reset;
    // outports wire
    wire   	b_my;
    
    mainset u_main(
        .clk   	( clk    ),
        .reset 	( reset  )
    );
    //生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //
    initial begin
        clk=0;
        reset=1;
        #2;
        reset=0;
        #20 $finish;
    end
    always #1 clk=~clk;
endmodule //tb
