from inspect import getsourcefile
from os.path import abspath, dirname
from PIL import Image, ImageDraw, ImageFont

def main():
    executed_file_dirname = dirname(abspath(getsourcefile(lambda:0)))
    img = Image.open(f'{executed_file_dirname}/../graphics/tilesheet.png')
    font = ImageFont.load_default()

    tiles_numerator(executed_file_dirname, img, font, 16, 16)


def tiles_numerator(executed_file_dirname, img, font, tile_width, tile_height):
    draw = ImageDraw.Draw(img)
    counter = 1
    for y in range(-1, img.height, tile_height):
        for x in range(1, img.width, tile_width):
            draw.text((x, y), str(counter), font=font, fill=(150, 50, 255))
            counter += 1

    img.save(f'{executed_file_dirname}/../graphics/tilesheet_numbered.png')


if __name__ == '__main__':
    main()