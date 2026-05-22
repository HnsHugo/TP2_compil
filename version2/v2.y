%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

int puissance(int base, int exp);
%}

%token NOMBRE

%%

programme : expr                   { printf("Résultat = %d\n", $1); }
          ;

expr      : expr '+' term          { $$ = $1 + $3; }
          | expr '-' term          { $$ = $1 - $3; }
          | term                   { $$ = $1; }
          ;

term      : term '*' factor        { $$ = $1 * $3; }
          | term '/' factor        { 
                                     if ($3 == 0) {
                                         fprintf(stderr, "Erreur : division par zéro\n");
                                         $$ = 0;
                                     } else {
                                         $$ = $1 / $3;
                                     }
                                   }
          | term '%' factor        {
                                     if ($3 == 0) {
                                         fprintf(stderr, "Erreur : modulo par zéro\n");
                                         $$ = 0;
                                     } else {
                                         $$ = $1 % $3;
                                     }
                                   }
          | factor                 { $$ = $1; }
          ;

factor    : base '^' factor        { $$ = puissance($1, $3); }
          | base                   { $$ = $1; }
          ;

base      : '(' expr ')'          { $$ = $2; }
          | NOMBRE                { $$ = $1; }
          ;

%%

int puissance(int base, int exp) {
    if (exp == 0) return 1;
    if (exp % 2 == 0) {
        int moitie = puissance(base, exp / 2);
        return moitie * moitie;
    }
    return base * puissance(base, exp - 1);
}

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