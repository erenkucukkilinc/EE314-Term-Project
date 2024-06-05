
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module topsecret(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
//	output		     [6:0]		HEX0,
//	output		     [6:0]		HEX1,
//	output		     [6:0]		HEX2,
//	output		     [6:0]		HEX3,
//	output		     [6:0]		HEX4,
//	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================

assign LEDR[4:0] = 4'hF;
	
	reg  r_25MHz; 
	wire w_25MHz;
	
	always @(posedge CLOCK_50) begin
		  r_25MHz <= ~r_25MHz;
	end
	
	assign w_25MHz = r_25MHz; // assert tick 1/2 of the time

	    // Internal Signals
    wire [9:0] w_x, w_y;
    wire de, w_reset;
    wire [23:0] rgb_next;
//    wire w_up, w_down, w_left, w_right;
    
    // Instantiate Inner Modules
    
    pixelGenerator pg(       //.clk_100MHz(clk_100MHz),
                        //.reset(w_reset),
                        .video_on(w_video_on),
                        .x(w_x),
                        .y(w_y),
                        .rgb(rgb_next));

            
    assign {VGA_R, VGA_G, VGA_B} = rgb_next;
	 assign VGA_CLK = w_25MHz;
	 assign VGA_BLANK_N = 1'b1;
	 assign VGA_SYNC_N = 1'b1;

endmodule