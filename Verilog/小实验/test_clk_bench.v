module testclkbench();
    reg a;
    testclk myclk(a);

    initial begin
        $dumpfile("test_clk.vcd");
        $dumpvars;
        #16 $finish;
    end

    initial begin
        a=0;
    end

    always #1 a=~a;

endmodule