#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <regex.h>
#include <string.h>

#define ARRAY_SIZE(arr) (sizeof((arr)) / sizeof((arr)[0]))

// static const char *const str =
//        "1) John Driverhacker;\n2) John Doe;\n3) John Foo;\n4) John Doe;";
// static const char *const re = "John.*o";
// static const char *const replace = "123";
// static const char *const one_symbol = "q";

int main(int argc, char *argv[]) {
    char* re = argv[1];
    char* s = argv[2];
    char* replace = argv[3];
    regex_t     regex;
    regmatch_t  pmatch[1];
    regoff_t    off, len;

   if (regcomp(&regex, re, REG_NEWLINE))
       exit(EXIT_FAILURE);

    int i = 0;
    char *result = (char*)malloc(10000);

    for (int _ = 0; ; _++) {
        if (regexec(&regex, s, ARRAY_SIZE(pmatch), pmatch, 0))
            break;

        off = pmatch[0].rm_so;
        len = pmatch[0].rm_eo - pmatch[0].rm_so;
        // printf("offset = %jd; length = %jd\n", (intmax_t) off, (intmax_t) len);

        for (int j = 0; j < off; j++) {
            result[i] = s[j];
            i += 1;
        }
        
        int replace_len = strlen(replace);
        for (int j = 0; j < replace_len; j++) {
            result[i] = replace[j];
            i += 1;
        }

        s += pmatch[0].rm_eo;
    }
    for (int j = 0; j < strlen(s); j++) {
        result[i] = s[j];
        i += 1;
    }
    printf("\n%s", result);
    exit(EXIT_SUCCESS);
}