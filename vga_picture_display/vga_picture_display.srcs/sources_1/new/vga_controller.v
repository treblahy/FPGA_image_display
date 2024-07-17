// VGA 640x480 @ 60 Hz
localparam H_DISPLAY = 640;    // Horizontal display width
localparam H_FRONT = 16;       // Horizontal front porch
localparam H_SYNC = 96;        // Horizontal sync pulse
localparam H_BACK = 48;        // Horizontal back porch
localparam H_TOTAL = H_DISPLAY + H_FRONT + H_SYNC + H_BACK; // Total horizontal pixels

localparam V_DISPLAY = 480;    // Vertical display height
localparam V_FRONT = 10;       // Vertical front porch
localparam V_SYNC = 2;         // Vertical sync pulse
localparam V_BACK = 33;        // Vertical back porch
localparam V_TOTAL = V_DISPLAY + V_FRONT + V_SYNC + V_BACK; // Total vertical pixels

module vga_controller (
    input wire clk,          // 25 MHz clock
    input wire reset,
    output wire hsync,
    output wire vsync,
    output wire [3:0] vga_r, // 4-bit red color signal
    output wire [3:0] vga_g, // 4-bit green color signal
    output wire [3:0] vga_b  // 4-bit blue color signal
);

    wire [11:0] pixel_data;  // 12-bit RGB pixel data

    reg [9:0] h_count = 0;   // Horizontal pixel counter
    reg [9:0] v_count = 0;   // Vertical pixel counter

    // Horizontal counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            h_count <= 0;
        end else if (h_count == H_TOTAL - 1) begin
            h_count <= 0;
        end else begin
            h_count <= h_count + 1;
        end
    end

    // Vertical counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            v_count <= 0;
        end else if (h_count == H_TOTAL - 1) begin
            if (v_count == V_TOTAL - 1) begin
                v_count <= 0;
            end else begin
                v_count <= v_count + 1;
            end
        end
    end

    // Generate hsync and vsync signals
    assign hsync = (h_count >= H_DISPLAY + H_FRONT) && (h_count < H_DISPLAY + H_FRONT + H_SYNC);
    assign vsync = (v_count >= V_DISPLAY + V_FRONT) && (v_count < V_DISPLAY + V_FRONT + V_SYNC);

    assign vga_r = (h_count < H_DISPLAY && v_count < V_DISPLAY) ? pixel_data[11:8] : 4'h0; // Red
    assign vga_g = (h_count < H_DISPLAY && v_count < V_DISPLAY) ? pixel_data[7:4] : 4'h0; // Green
    assign vga_b = (h_count < H_DISPLAY && v_count < V_DISPLAY) ? pixel_data[3:0] : 4'h0; // Blue

    // Count address for frame buffer to use
    wire [18:0] address = (v_count * H_DISPLAY) + h_count;
    
    // Get data from frame buffer
    frame_buffer fb (
        .clk(clk),
        .address(address),
        .pixel_data(pixel_data),
        .reset(pause)
    );

endmodule