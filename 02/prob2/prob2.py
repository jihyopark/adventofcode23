import re

def main():
    with open('./input.txt') as openfileobject:

        ret = 0

        for line in openfileobject:
            line_num = re.match(r"[0-9]+", line[5:]).group(0)
            line = line[(len(line_num) + 7):]
            if line[-1] == '\n':
                line = line[:-1]
            draws = line.split("; ")

            red, green, blue = 0, 0, 0

            for draw in draws:

                cubes = re.split(r"\W+", draw)

                for i in range(0, len(cubes), 2):
                    if cubes[i + 1] == "red":
                        red = max(red, int(cubes[i]))

                    elif cubes[i + 1] == "green":
                        green = max(green, int(cubes[i]))

                    else:
                        blue = max(blue, int(cubes[i]))


            # print(red, green, blue)
            ret += red * green * blue

        print(ret)

main()