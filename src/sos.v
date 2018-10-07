module sos_gen(
    input clk,
    input rst,
    output out
);

reg slow = 0;
reg [1:0] clk_count = 0;
reg [1:0] sos_count = 0;

wire out_clk = clk_count[slow];
assign out = out_clk;

always @(posedge clk, posedge rst)
    if (rst)
        clk_count <= 'b10;
    else
        clk_count <= clk_count + 1;

always @(posedge out_clk, posedge rst)
begin
    if (rst) begin
        sos_count <= 0;
        slow <= 0;
    end else if (sos_count == 3) begin
        sos_count <= 0;
        slow <= ~slow;
    end else begin
        sos_count <= sos_count + 1;
    end
end

endmodule
