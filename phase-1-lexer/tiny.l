%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yyline = 1;
int yycolumn = 1;
%}

%option noyywrap

%%

"--".* {
    yycolumn += strlen(yytext);
}

[ \t] {
    yycolumn += strlen(yytext);
}

\n {
    yyline++;
    yycolumn = 1;
}

"program" { printf("PROGRAM\n"); yycolumn += 7; }
"beginprogram" { printf("BEGIN_PROGRAM\n"); yycolumn += 12; }
"endprogram" { printf("END_PROGRAM\n"); yycolumn += 10; }
"integer" { printf("INTEGER\n"); yycolumn += 7; }
"array" { printf("ARRAY\n"); yycolumn += 5; }
"of" { printf("OF\n"); yycolumn += 2; }
"if" { printf("IF\n"); yycolumn += 2; }
"then" { printf("THEN\n"); yycolumn += 4; }
"endif" { printf("ENDIF\n"); yycolumn += 5; }
"else" { printf("ELSE\n"); yycolumn += 4; }
"while" { printf("WHILE\n"); yycolumn += 5; }
"loop" { printf("LOOP\n"); yycolumn += 4; }
"endloop" { printf("ENDLOOP\n"); yycolumn += 7; }
"read" { printf("READ\n"); yycolumn += 4; }
"write" { printf("WRITE\n"); yycolumn += 5; }
"and" { printf("AND\n"); yycolumn += 3; }
"or" { printf("OR\n"); yycolumn += 2; }
"not" { printf("NOT\n"); yycolumn += 3; }
"true" { printf("TRUE\n"); yycolumn += 4; }
"false" { printf("FALSE\n"); yycolumn += 5; }

":=" { printf("ASSIGN\n"); yycolumn += 2; }
"<=" { printf("LTE\n"); yycolumn += 2; }
">=" { printf("GTE\n"); yycolumn += 2; }
"<>" { printf("NEQ\n"); yycolumn += 2; }
"+" { printf("ADD\n"); yycolumn += 1; }
"-" { printf("SUB\n"); yycolumn += 1; }
"*" { printf("MULT\n"); yycolumn += 1; }
"/" { printf("DIV\n"); yycolumn += 1; }
"=" { printf("EQ\n"); yycolumn += 1; }
"<" { printf("LT\n"); yycolumn += 1; }
">" { printf("GT\n"); yycolumn += 1; }
";" { printf("SEMICOLON\n"); yycolumn += 1; }
":" { printf("COLON\n"); yycolumn += 1; }
"," { printf("COMMA\n"); yycolumn += 1; }
"(" { printf("L_PAREN\n"); yycolumn += 1; }
")" { printf("R_PAREN\n"); yycolumn += 1; }

[0-9]+ {
    printf("NUMBER %s\n", yytext);
    yycolumn += strlen(yytext);
}

[0-9_][a-zA-Z0-9_]* {
    fprintf(stderr, "Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", yyline, yycolumn-1, yytext);
    exit(1);
}

[a-zA-Z][a-zA-Z0-9_]* {
    int len = strlen(yytext);
    if (yytext[len - 1] == '_') {
        fprintf(stderr, "Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", yyline, yycolumn-1, yytext);
        exit(1);
    }
    printf("IDENT %s\n", yytext);
    yycolumn += len;
}

. {
    fprintf(stderr, "Error at line %d, column %d: unrecognized symbol \"%s\"\n", yyline, yycolumn-1, yytext);
    exit(1);
}

%%

int main() {
    yylex();
    return 0;
}