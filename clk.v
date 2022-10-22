module clock(output clk);
    reg clk;
    initial
        clk = 0;
    always begin
        $display("clk",clk);
        #5 clk = ~clk;
    end

    always
        #1000 $finish;
endmodule