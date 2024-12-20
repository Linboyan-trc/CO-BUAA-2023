module testbench();
    reg a;
    reg b;
    wire out;
    Xnor myXnor(a,b,out);

    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
        #16 $finish;
    end

    initial begin
        #1 a=0;
        b=0;
        #1 a=1;
        b=0;
        #1 a=0;
        b=1;
        #1 a=1;
        b=1;
    end

endmodule

