`include "adder32bit.v"

module ALU(a,b,Binvert,Carryin,Operation,Result,CarryOut);
	input [31:0] a, b;
	input [1:0] Operation;
	input Carryin, Binvert;
	output reg [31:0] Result;
	output CarryOut;
	
	wire [31:0] wa, wb, wc;
	wire [31:0]binvert_32;
	assign binvert_32 = {32{Binvert}};
	assign {wa} = a & b;
	assign {wb} = a | b;
	
	adder32bit adder(wc,CarryOut,a,b^binvert_32,Carryin);
	always @(*) begin
	if(Operation == 2'b00) begin
		Result<= wa;
	end else if(Operation == 2'b10) begin
		 Result <= wb;
	end else if(Operation == 2'b01) begin 
		 Result <= wc;
	end
	end

endmodule
	
module tbALU;
	reg Binvert, Carryin;
	reg [1:0] Operation;
	reg [31:0] a,b;
	wire [31:0] Result;
	wire CarryOut;
	ALU A(a,b,Binvert,Carryin,Operation,Result,CarryOut);
	//initial
	//begin
	//=32'ha5a5a5a5;
	//b=32'h5a5a5a5a;
	//Operation=2'b00;
	//Binvert=1'b0;
	//Carryin=1'b0; //must perform AND resulting in 
	//end
	initial begin 
	$monitor("a = %b, b = %b, Operation = %b, Binvert = %b, Carryin = %b, Result = %b", a, b, Operation, Binvert, Carryin, Result);
	#100 Operation=2'b01; //OR
	#100 Operation=2'b10; //ADD
	#100 Binvert=1'b1;//SUB
	#200 $finish;
	end
endmodule