%{
    #include <stdio.h>
    #include <ctype.h>
%}

digit   [0-9]
letter  [a-zA-Z]
letter_ ({letter}|_)
id      {letter_}({letter_}|{digit})*
select  [Ss][Ee][Ll][Ee][Cc][Tt]
from    [Ff][Rr][Oo][Mm]
where   [Ww][Hh][Ee][Rr][Ee]
string  \"(\\.|[^"\\])*\"

%%

{string} { printf("%s", yytext); }
{select} { printf("SELECT"); }
{from} { printf("FROM"); }
{where} { printf("WHERE"); }
{id} { printUpperYYText(); }

%%

void printUpperYYText() {
    for (int i = 0; yytext[i]; i++) {
        printf("%c", toupper(yytext[i]));
    }
}

int main(int argc, char* argv[]) {    
    if (argc != 2) {
        printf("Укажите имя файла\n");
        exit(0);
    }

    freopen(argv[1], "r", stdin);
    yyset_in(stdin);
    yylex();
    fclose(stdin);
    exit(0);
}