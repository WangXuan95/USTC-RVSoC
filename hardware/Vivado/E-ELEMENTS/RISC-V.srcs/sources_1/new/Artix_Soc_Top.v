module Artix_SoC_top(

////////////CLOCK//////////
input 		          		CLK_50,

//////////SEG8//////////
output 		   [7:0]       	SEL,
output 		   [7:0]     	DIG,

////////////KEY//////////
//input 		     [3:0]		KEY,

////////////VGA//////////
output		     [3:0]		VGA_B,
output		     [3:0]		VGA_G,
output		          		VGA_HS,
output		     [3:0]		VGA_R,
output		          		VGA_VS,

////////////Serial Port//////////
output 		          		UART_TXD,
input 		          		UART_RXD 

);


//=======================================================
//  REG/WIRE declarations
wire clk;
//=======================================================
wire vga_red, vga_green, vga_blue;
assign VGA_R = {4{vga_red}};
assign VGA_G = {4{vga_green}};
assign VGA_B = {4{vga_blue}};

soc_top soc0(
    .clk              ( CLK_50    ),
    .isp_uart_rx      ( UART_RXD  ),
    .isp_uart_tx      ( UART_TXD  ),
    .SEL      		  ( SEL       ),
    .DIG      		  ( DIG       ),
    .vga_hsync        ( VGA_HS    ),
    .vga_vsync        ( VGA_VS    ),
    .vga_red          ( vga_red   ),
    .vga_green        ( vga_green ),
    .vga_blue         ( vga_blue  )
);

endmodule
