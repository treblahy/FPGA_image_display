module top (
    input wire clk,         // 100 MHz clock input
    input wire reset,       // Reset signal
    output wire hsync,
    output wire vsync,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
);

    // Clock divider to generate 25 MHz clock from 100 MHz input
    reg [1:0] clk_div;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_div <= 0;
        end else begin
            clk_div <= clk_div + 1;
        end
    end

    wire clk_25MHz = clk_div[1];

    // Instantiate VGA controller
    vga_controller vga_inst (
        .clk(clk_25MHz),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

endmodule
