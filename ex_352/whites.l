%{
    #include<stdio.h>
%}

delim      [ \t\n]
ws         {delim}+
%%

{ws} {printf(" ");}

%%

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
