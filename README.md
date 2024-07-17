# FPGA image display
A Vivado project which displays a 640x480 image using VGA output, plus a python script to turn .jpg image to .mem file format.


### Requirements
To run this project, you will need the following:
* Nexys 4 DDR FPGA board
* A screen with VGA input + VGA cable
* Xilinx Vivado 2023.2 or versions later
* A machine with python3, pillow and numpy installed


### File structure
**vga_picture_display**: The Vivado project itself with source code.

**jpg2mem.py**: A python script for converting .jpg picture to .mem file format.

**test.jpg**: The original picture in jpg format.

**test.mem**: The converted .mem format, also included in the project files.

### Modules
**top.v**: The module which generates the necessary clock and instantiate the vga_controller module.

**vga_controller.v**: The module which handles the vga display, and gets data from the frame_buffer module.

**frame_buffer.v**: Read the memory from test.mem and output the pixel data based on the address vga_controller given.

### Instructions
1. Clone the repository onto your machine, or download ZIP file through github webpage.
2. To convert the image of your choice, rename your image to `test.jpg` (or edit the python script), then run the script.
  (If pillow or numpy isn't installed, run `pip install pillow` or `pip install numpy` in your terminal)
3. Put the new converted test.mem into /vga_picture_display/vga_picture_display.srcs/source_1/new/
4. Open the project with Xilinx Vivado (by double clicking vga_picture_display/vga_picture_display.xpr)
5. On the left side of the Vivado window, click run synthesis.
6. After synthesis is completed, on the left side of the Vivado window, click run implementation.
7. After implementation is completed, on the left side of the Vivado window, click generate bitstream.
8. After bitstream file is generated, in the green bar at the top of the Vivado window, click Open target. Select Auto connect from the drop down menu.
9. In the green bar at the top of the Vivado window, click Program device, then click Program.
10. The project will now be programmed onto the Nexys 4 DDR. Connect the VGA output on Nexys 4 DDR FPGA board to your screen to see the result.

### License
This project is licensed under the MIT License. See the LICENSE file for details.
