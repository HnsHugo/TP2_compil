%{
#include "v2.tab.h"     
%}

%%

[0-9]+      {
                int r = yytext[0] - '0';
                int i = 1;
                while (yytext[i] != '\0') {
                    r = r * 10 + (yytext[i] - '0');
                    i++;
                }
                yylval = r;
                return NOMBRE;
            }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"%"         { return '%'; }
"^"         { return '^'; }
"("         { return '('; }
")"         { return ')'; }
[ \t\n]     { /* ignorer espaces */ }
.           { fprintf(stderr, "Caractère inconnu : %s\n", yytext); }

%%

int yywrap() { return 1; }