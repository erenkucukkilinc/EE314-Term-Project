
module pixelGenerator(
    input clk_50MHz,   // sys clock
    //input reset,        // sys reset
    input video_on,     // from VGA controller
    input [9:0] x,      // from VGA controller
    input [9:0] y,      // from VGA controller
    output reg [23:0] rgb   // to VGA port
    );
    
    // RGB Color Values
    parameter RED    	= 24'hFF0000;
    parameter GREEN  	= 24'h00FF00;
    parameter BLUE   	= 24'h0000FF;
    parameter YELLOW 	= 24'hFFFF00; 
    parameter BLACK  	= 24'h000000;
	 parameter GRAY   	= 24'hA0A0A0;
	 parameter DARK_BLUE = 24'h0000CC;
	 parameter CHARACTER	= 24'hCC0000;
    
    // Pixel Location Status Signals
    wire bottom_green_on, top_black_on, left_green_on, right_green_on;
    wire upper_green__on, upper_yellow_on, lower_yellow_on;
    wire home1_on, home2_on, home3_on, home4_on, home5_on;      // all homes blue
    wire wall1_on, wall2_on, wall3_on, wall4_on;                // all walls green
    wire street_on, water_on;
	 
	 wire background_on;
	 reg line1_on;
	 reg line2_on;
	 reg line3_on;
	 reg line4_on;
	 reg line5_on;	 
	 reg line6_on; 
	 reg line7_on; 
	 reg line8_on; 	
	 
	 wire [5:0] col;
	 wire [5:0] row;
	
	
	
	 
    
    // Drivers for Status Signals
//    assign bottom_green_on  = ((x >= 0)   && (x < 640)   &&  (y >= 452) && (y < 480));
//    assign top_black_on = ((x >= 0)  && (x < 640)  &&  (y >= 0) && (y < 32));
//    assign left_green_on   = ((x >= 0) && (x < 32)  &&  (y >= 32) && (y < 452));
//    assign right_green_on  = ((x >= 608) && (x < 640)  &&  (y >= 32) && (y < 452));
//    assign upper_green_on = ((x >= 32) && (x < 608)  &&  (y >= 32) && (y < 36));
//    assign upper_yellow_on    = ((x >= 32) && (x < 608)  &&  (y >= 228) && (y < 260));
//    assign lower_yellow_on   = ((x >= 32) && (x < 608)  &&  (y >= 420) && (y < 452));
//    assign home1_on = ((x >= 32)   && (x < 96)   &&  (y >= 36) && (y < 68));
//    assign wall1_on  = ((x >= 96) && (x < 160)  && (y >= 36) && (y < 68));
//    assign home2_on = ((x >= 160) && (x < 224)  &&  (y >= 36) && (y < 68));
//    assign wall2_on  = ((x >= 224) && (x < 288)  && (y >= 36) && (y < 68));
//    assign home3_on = ((x >= 288) && (x < 352)  &&   (y >= 36) && (y < 68));
//    assign wall3_on  = ((x >= 352) && (x < 416)  && (y >= 36) && (y < 68));
//    assign home4_on = ((x >= 416) && (x < 480)  &&  (y >= 36) && (y < 68));
//    assign wall4_on  = ((x >= 480) && (x < 544)  && (y >= 36) && (y < 68));
//    assign home5_on = ((x >= 544) && (x < 608)  &&  (y >= 36) && (y < 68));    
//    assign street_on = ((x >= 32) && (x < 608)  && (y >= 260) && (y < 420));
//    assign water_on = ((x >= 32) && (x < 608)  &&  (y >= 68) && (y < 228));
	 
	 assign background_on =  ((x >= 0)   && (x < 640)   &&  (y >= 0) && (y < 480));
	 assign rightScreen_on = ((x >= 480) && (x < 640)   &&  (y >= 0) && (y < 480));
	 assign player_on = ((x >= 232) && (x < 248)   &&  (y >= 232) && (y < 248));
	 assign origin_on = (x == 240)   &&  (y == 240);
	 
    always @(*) begin
		if (x == y) begin // 145
			line1_on = x[1];
		end else begin
			line1_on = 0;
		end
		
		if (x+y == 479) begin // 45
			line2_on = x[1];
		end else begin
			line2_on = 0;
		end
		
		if (x == 239) begin // 180
			line3_on = y[1];
		end else begin
			line3_on = 0;
		end
		
		if (y == 239) begin // 90
			line4_on = x[1];
		end else begin
			line4_on = 0;
		end
		
		if (2*y+x == 718) begin // 22.5
			line5_on = y[0];
		end else begin
			line5_on = 0;
		end
		
		if (2*y-x == 238) begin // 167.5
			line6_on = y[0];
		end else begin
			line6_on = 0;
		end
	
		if (2*x-y == 238) begin // 112.5
			line7_on = x[0];
		end else begin
			line7_on = 0;
		end
		
		if (2*x + y == 718) begin // 67.5
			line8_on = x[0];
		end else begin
			line8_on = 0;
		end
		
	 end
	 
	 
	 
    // Set RGB output value based on status signals
    always @(*) begin
        if(~video_on) begin
			  rgb = BLACK; 
		  end else begin
			  if (origin_on) begin
					rgb = RED;
			  end else if (rightScreen_on) begin
					rgb = DARK_BLUE;
			  end else if (player_on) begin
					  rgb = CHARACTER;
			  end else begin
					  if(background_on) rgb = GRAY;
					  if(line1_on) rgb = BLACK;
					  if(line2_on) rgb = BLACK;
					  if(line3_on) rgb = BLACK;
					  if(line4_on) rgb = BLACK;
					  if(line5_on) rgb = BLACK;
					  if(line6_on) rgb = BLACK;	
					  if(line7_on) rgb = BLACK;
					  if(line8_on) rgb = BLACK;				  
			  end
				 
		  end
		  
	end

   
endmodule
