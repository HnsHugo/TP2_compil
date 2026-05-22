%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NOMBRE

%%

programme : expr               { printf("Résultat = %d\n", $1); }
          ;

expr      : expr '+' term      { $$ = $1 + $3; }
          | term               { $$ = $1; }
          ;

term      : term '*' factor    { $$ = $1 * $3; }
          | factor             { $$ = $1; }
          ;

factor    : '(' expr ')'      { $$ = $2; }
          | NOMBRE            { $$ = $1; }
          ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur : %s\n", s);
}

int main() {
    extern FILE *yyin;
    yyin = fopen("expression.txt", "r");
    if (!yyin) {
        perror("Impossible d'ouvrir le fichier");
        return 1;
    }
    yyparse();
    fclose(yyin);
    return 0;
}