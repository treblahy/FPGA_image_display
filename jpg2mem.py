from PIL import Image
import numpy as np
import os

def convert_jpg_to_mem(input_img, output_file):
    # Open the image file
    with Image.open(input_img) as img:
        # Save the image as BMP format
        img = img.resize((640, 480))
        img = img.convert('RGB')

        # Convert image to numpy array
        pixel_data = np.array(img)

    with open(output_file, 'w') as f:
        for y in range(480):
            for x in range(640):
                r, g, b = pixel_data[y,x]

                # Convert 8-bit RGB to 4-bit RGB
                r = np.uint8(r / 16)
                g = np.uint8(g / 16)
                b = np.uint8(b / 16)

                # Combine the 4-bit RGB values into a single 12-bit pixel value
                pixel_value = (r << 8) | (g << 4) | b
                f.write(f'{pixel_value:03X}\n')  # Write in hexadecimal format
    print(f"Converted {input_img} to {output_file}")

convert_jpg_to_mem('test.jpg', 'test1.mem')
