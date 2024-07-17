module frame_buffer (
    input wire clk,
    input wire [18:0] address,    // Address for 640x480 resolution (19 bits: log2(307200))
    output reg [11:0] pixel_data,  // 12-bit RGB pixel data
    input wire reset
);

    integer i, j;

    // Memory array to hold pixel data
    reg [11:0] memory [0:307199];  // 12-bit RGB data for 307200 pixels
    
    // Initialize memory with .mem file
    initial begin
        $readmemh("test.mem", memory);  // Initialize memory with .mem file
    end

    // Output pixel data based on address
    always @(posedge clk) begin
        pixel_data <= memory[address];
    end

endmodule
