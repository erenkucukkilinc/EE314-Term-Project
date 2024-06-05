module character_rotate(
input button0,
input button1,
output [b 
);

reg [4:0]counter = 0;


always @(negedge button1) begin
	counter <= counter +1;
end

always @(negedge button0) begin
	counter <= counter -1;
end

assign position = counter;

endmodule
