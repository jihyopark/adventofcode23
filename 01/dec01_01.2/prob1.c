#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int num_as_int(char **num) {

    int i;

    if (strncmp(*num, "one", 3) == 0) {
        // (*num) += 3;
        return 1;
    }
    else if (strncmp(*num, "two", 3) == 0) {
        // (*num) += 3;
        return 2;
    }
    else if (strncmp(*num, "three", 5) == 0) {
        // (*num) += 5;
        return 3;
    }
    else if (strncmp(*num, "four", 4) == 0) {
        // (*num) += 4;
        // printf("%s", *num);
        return 4;
    }
    else if (strncmp(*num, "five", 4) == 0) {
        // (*num) += 4;
        return 5;
    }
    else if (strncmp(*num, "six", 3) == 0) {
        // (*num) += 3;
        return 6;
    }
    else if (strncmp(*num, "seven", 5) == 0) {
        // (*num) += 5;
        return 7;
    }
    else if (strncmp(*num, "eight", 5) == 0) {
        // (*num) += 5;
        return 8;
    }
    else if (strncmp(*num, "nine", 4) == 0) {
        // (*num) += 4;
        return 9;
    }
    else if (**num >= '1' && **num <= '9') {
        i = **num - '0';
        // (*num)++;
        return i;
    }
    else {
        // (*num)++;
        return -1;
    }
}

int main() {
    
    FILE *fp;
    char input_line[80];
    char *line_parse;

    int sum = 0;
    int n;
    int second;

    fp = fopen("input.txt" , "r");

    if (fp == NULL) {
        perror("Error opening file");
        return(-1);
    }

    while (fgets(input_line, 80, fp) != NULL) {
        line_parse = input_line;
        second = -1;

        while (*line_parse != NULL) {

            n = num_as_int(&line_parse);

            if (n != -1) {
                if (second == -1) {
                    sum += 10 * n;
                }

                second = n;
            }

            line_parse++;
        }

        sum += second;

        // printf("%d\n", sum);

    }

    fclose(fp);

    printf("%d\n", sum);

    return 0;
}