module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule


module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7,
			   c = d3 | d5 | d6 | d7;
endmodule


module bit_8_FADDER(s, c, x, y, cin);
	input [7:0] x;
	input [7:0] y;
	input cin;
	output [7:0] s;
	output c;
	wire [7:0] a;
	FADDER f0(s[0], a[0], x[0], y[0], cin);
	FADDER f1(s[1], a[1], x[1], y[1], a[0]);
	FADDER f2(s[2], a[2], x[2], y[2], a[1]);
	FADDER f3(s[3], a[3], x[3], y[3], a[2]);
	FADDER f4(s[4], a[4], x[4], y[4], a[3]);
	FADDER f5(s[5], a[5], x[5], y[5], a[4]);
	FADDER f6(s[6], a[6], x[6], y[6], a[5]);
	FADDER f7(s[7], c, x[7], y[7], a[6]);
	
endmodule

module bit_32_FADDER(s,c , x, y, cin);
	input [31:0] x;
	input [31:0] y;
	input cin;
	output [31:0] s;
	output c;
	wire [0:3] a;
	
	bit_8_FADDER f0(s[7:0], a[0], x[7:0], y[7:0], cin);
	bit_8_FADDER f1(s[15:8], a[1], x[15:8], y[15:8], a[0]);
	bit_8_FADDER f2(s[23:16], a[2], x[23:16], y[23:16], a[1]);
	bit_8_FADDER f3(s[31:24], c, x[31:24], y[31:24], a[2]);
	
endmodule

module testbench;
	reg [0:31] x;
	reg [0:31] y;
	reg z;
	wire [0:31] s;
	wire c;
	bit_32_FADDER fl(s,c,x,y,z);
	initial
	$monitor(,$time,"x=%b,y=%b,z=%b,s=%b,c=%b",x,y,z,s,c);
	initial
	begin
	#0 x=32'b01010101010101010101010101010101;y=32'b00101010101010101010101010101010;z=1'b0;
	#1 x=32'b01010101010101010101010101010101;y=32'b00101010101010101010101010101010;z=1'b1;
	end
endmodule