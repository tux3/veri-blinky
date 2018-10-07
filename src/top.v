// LED blinker - Generates an SOS-like clock pattern

module top(
    input CLK_16MHZ,
    input RESETN,
    output LED
);

// Controls output speed (Divide PLL's output clock by 2^CLK_DIV)
parameter CLK_DIV = 21;

wire clk, rst;
reg [CLK_DIV:0] slow_clk_counter = 0;
wire slow_clk = slow_clk_counter[CLK_DIV];

pll pll(
    .clk_in(CLK_16MHZ),
    .resetb_in(RESETN),
    .clk_out(clk),
    .reset_out(rst)
);

sos_gen led_pattern_gen(
    .clk(slow_clk),
    .rst(rst),
    .out(LED)
);

always @(posedge clk)
begin
    if (rst)
        slow_clk_counter <= 0;
    else
        slow_clk_counter <= slow_clk_counter + 1;
end

endmodule
