%{
#include "y.tab.h"
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

"program" { yycolumn += strlen(yytext); return PROGRAM; }
"beginprogram" { yycolumn += strlen(yytext); return BEGIN_PROGRAM; }
"endprogram" { yycolumn += strlen(yytext); return END_PROGRAM; }
"integer" { yycolumn += strlen(yytext); return INTEGER; }
"array" { yycolumn += strlen(yytext); return ARRAY; }
"of" { yycolumn += strlen(yytext); return OF; }
"if" { yycolumn += strlen(yytext); return IF; }
"then" { yycolumn += strlen(yytext); return THEN; }
"endif" { yycolumn += strlen(yytext); return ENDIF; }
"else" { yycolumn += strlen(yytext); return ELSE; }
"while" { yycolumn += strlen(yytext); return WHILE; }
"loop" { yycolumn += strlen(yytext); return LOOP; }
"endloop" { yycolumn += strlen(yytext); return ENDLOOP; }
"read" { yycolumn += strlen(yytext); return READ; }
"write" { yycolumn += strlen(yytext); return WRITE; }
"and" { yycolumn += strlen(yytext); return AND; }
"or" { yycolumn += strlen(yytext); return OR; }
"not" { yycolumn += strlen(yytext); return NOT; }
"true" { yycolumn += strlen(yytext); return TRUE; }
"false" { yycolumn += strlen(yytext); return FALSE; }

":=" { yycolumn += strlen(yytext); return ASSIGN; }
"<=" { yycolumn += strlen(yytext); return LTE; }
">=" { yycolumn += strlen(yytext); return GTE; }
"<>" { yycolumn += strlen(yytext); return NEQ; }
"+" { yycolumn += strlen(yytext); return ADD; }
"-" { yycolumn += strlen(yytext); return SUB; }
"*" { yycolumn += strlen(yytext); return MULT; }
"/" { yycolumn += strlen(yytext); return DIV; }
"=" { yycolumn += strlen(yytext); return EQ; }
"<" { yycolumn += strlen(yytext); return LT; }
">" { yycolumn += strlen(yytext); return GT; }
";" { yycolumn += strlen(yytext); return SEMICOLON; }
":" { yycolumn += strlen(yytext); return COLON; }
"," { yycolumn += strlen(yytext); return COMMA; }
"(" { yycolumn += strlen(yytext); return L_PAREN; }
")" { yycolumn += strlen(yytext); return R_PAREN; }

[0-9]+ {
    yylval.num = atoi(yytext);
    yycolumn += strlen(yytext);
    return NUMBER;
}

[_0-9][a-zA-Z0-9_]* {
    fprintf(stderr, "Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", yyline, yycolumn, yytext);
    exit(1);
}

[a-zA-Z][a-zA-Z0-9_]* {
    int len = strlen(yytext);
    if (yytext[len - 1] == '_') {
        fprintf(stderr, "Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", yyline, yycolumn, yytext);
        exit(1);
    }
    yylval.str = strdup(yytext);
    yycolumn += len;
    return IDENT;
}

. {
    fprintf(stderr, "Error at line %d, column %d: unrecognized symbol \"%s\"\n", yyline, yycolumn, yytext);
    exit(1);
}

%%
