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

            breaked = False
            
            for draw in draws:
                cubes = re.split(r"\W+", draw)

                for i in range(0, len(cubes), 2):
                    if (cubes[i + 1] == "red" and int(cubes[i]) > 12) or (cubes[i + 1] == "green" and int(cubes[i]) > 13) or (cubes[i + 1] == "blue" and int(cubes[i]) > 14):
                        breaked = True
                        break
                
                if breaked:
                    break

            if not breaked:
                ret += int(line_num)

        print(ret)

main()