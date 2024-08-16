module bcd_to_gray(a, b, c, d, p, q, r, s);
    input a, b, c, d;
    output p, q, r, s;
    wire e, f, g, h;

    and(p, a, 1);
    or(q, a, b);
    xor(r, b, c);
    xor(s, c, d);

endmodule 

module testbench;
    reg a, b, c, d;
    wire p, q, r, s;
    bcd_to_gray bcd_to_gray1 (a, b, c, d, p, q, r, s);
    initial begin
        $monitor(,$time,"a=%b, b=%b, c=%b, d=%b, p=%b, q=%b, r=%b, s=%b", a, b, c, d, p, q, r, s);
        #0 a=1'b0;b=1'b1;c=1'b0;d=1'b1;
        #5 a=1'b1;b=1'b0;c=1'b1;d=1'b1;
        #10 $finish;
    end
	initial begin
		$dumpfile("filename.vcd");
		$dumpvars;
	end
endmodule