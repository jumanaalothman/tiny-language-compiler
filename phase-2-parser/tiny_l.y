%{
#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yyline;
extern int yycolumn;  
extern int yylex(void);
void yyerror(const char *msg);

void print_production(const char *lhs, const char *rhs) {
    printf("%s -> %s\n", lhs, rhs);
}
%}

%token PROGRAM BEGIN_PROGRAM END_PROGRAM INTEGER ARRAY OF
%token IF THEN ELSE ENDIF WHILE LOOP ENDLOOP READ WRITE
%token AND OR NOT TRUE FALSE
%token ASSIGN LTE GTE NEQ ADD SUB MULT DIV EQ LT GT
%token SEMICOLON COLON COMMA L_PAREN R_PAREN
%token <str> IDENT
%token <num> NUMBER

%union {
    char *str;
    int num;
}


%left OR
%left AND
%left NOT
%left EQ NEQ LT GT LTE GTE
%left ADD SUB
%left MULT DIV
%right UMINUS

%%

program: PROGRAM IDENT SEMICOLON declarations BEGIN_PROGRAM stmts END_PROGRAM
        { print_production("program", "PROGRAM IDENT SEMICOLON declarations BEGIN_PROGRAM stmts END_PROGRAM"); }
        ;

declarations : declaration_list
             { print_production("declarations", "declaration_list"); }
             | /* empty */
             { print_production("declarations", "ε"); }
             ;

declaration_list : declaration declaration_list
                 { print_production("declaration_list", "declaration declaration_list"); }
                 | declaration
                 { print_production("declaration_list", "declaration"); }
                 ;

declaration : ident_list COLON type SEMICOLON
            { print_production("declaration", "ident_list COLON type SEMICOLON"); }
            ;

ident_list : IDENT
           { print_production("ident_list", "IDENT"); }
           | ident_list COMMA IDENT
           { print_production("ident_list", "ident_list COMMA IDENT"); }
           ;

type : INTEGER
     { print_production("type", "INTEGER"); }
     | ARRAY L_PAREN NUMBER R_PAREN OF INTEGER
     { print_production("type", "ARRAY L_PAREN NUMBER R_PAREN OF INTEGER"); }
     ;

stmts : stmt stmts
      { print_production("stmts", "stmt stmts"); }
      | stmt
      { print_production("stmts", "stmt"); }
      ;

stmt : assignment_stmt
     { print_production("stmt", "assignment_stmt"); }
     | if_stmt
     { print_production("stmt", "if_stmt"); }
     | while_stmt
     { print_production("stmt", "while_stmt"); }
     | read_stmt
     { print_production("stmt", "read_stmt"); }
     | write_stmt
     { print_production("stmt", "write_stmt"); }
     ;

assignment_stmt : lvalue ASSIGN expr SEMICOLON
                { print_production("assignment_stmt", "lvalue ASSIGN expr SEMICOLON"); }
                ;

if_stmt : IF cond THEN stmts ENDIF SEMICOLON
        { print_production("if_stmt", "IF cond THEN stmts ENDIF SEMICOLON"); }
        | IF cond THEN stmts ELSE stmts ENDIF SEMICOLON
        { print_production("if_stmt", "IF cond THEN stmts ELSE stmts ENDIF SEMICOLON"); }
        ;

while_stmt : WHILE cond LOOP stmts ENDLOOP SEMICOLON
           { print_production("while_stmt", "WHILE cond LOOP stmts ENDLOOP SEMICOLON"); }
           ;

read_stmt : READ var_list SEMICOLON
          { print_production("read_stmt", "READ var_list SEMICOLON"); }
          ;

write_stmt : WRITE expr_list SEMICOLON
           { print_production("write_stmt", "WRITE expr_list SEMICOLON"); }
           ;

var_list : IDENT var_tail
         { print_production("var_list", "IDENT var_tail"); }
         ;

var_tail : COMMA IDENT var_tail
         { print_production("var_tail", "COMMA IDENT var_tail"); }
         | /* empty */
         { print_production("var_tail", "ε"); }
         ;

expr_list : expr expr_tail
          { print_production("expr_list", "expr expr_tail"); }
          ;

expr_tail : COMMA expr expr_tail
          { print_production("expr_tail", "COMMA expr expr_tail"); }
          | /* empty */
          { print_production("expr_tail", "ε"); }
          ;

cond : expr EQ expr
     { print_production("cond", "expr EQ expr"); }
     | expr NEQ expr
     { print_production("cond", "expr NEQ expr"); }
     | expr LT expr
     { print_production("cond", "expr LT expr"); }
     | expr GT expr
     { print_production("cond", "expr GT expr"); }
     | expr LTE expr
     { print_production("cond", "expr LTE expr"); }
     | expr GTE expr
     { print_production("cond", "expr GTE expr"); }
     | NOT cond
     { print_production("cond", "NOT cond"); }
     | cond AND cond
     { print_production("cond", "cond AND cond"); }
     | cond OR cond
     { print_production("cond", "cond OR cond"); }
     | L_PAREN cond R_PAREN
     { print_production("cond", "L_PAREN cond R_PAREN"); }
     ;

expr : expr ADD term
     { print_production("expr", "expr ADD term"); }
     | expr SUB term
     { print_production("expr", "expr SUB term"); }
     | term
     { print_production("expr", "term"); }
     ;

term : term MULT factor
     { print_production("term", "term MULT factor"); }
     | term DIV factor
     { print_production("term", "term DIV factor"); }
     | factor
     { print_production("term", "factor"); }
     ;

factor : L_PAREN expr R_PAREN
       { print_production("factor", "L_PAREN expr R_PAREN"); }
       | NUMBER
       { print_production("factor", "NUMBER"); }
       | IDENT
       { print_production("factor", "IDENT"); }
       | IDENT L_PAREN expr R_PAREN
       { print_production("factor", "IDENT L_PAREN expr R_PAREN"); }
       ;

lvalue : IDENT
       { print_production("lvalue", "IDENT"); }
       | IDENT L_PAREN expr R_PAREN
       { print_production("lvalue", "IDENT L_PAREN expr R_PAREN"); }
       ;
%%

void yyerror(const char *msg) {
    fprintf(stderr, "Syntax error at line %d\n", yyline);
}

int main() {
    yyparse();
    return 0;
}
