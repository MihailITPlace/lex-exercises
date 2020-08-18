%{
    #include<stdio.h>
%}

digit   [0-9]
letter  [a-zA-Z]
letter_ ({letter}|_)
id      {letter_}({letter_}|{digit})*
number  {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
STRING  \"(\\.|[^"\\])*\"

%%
{STRING} {    
    char *newStr = (char *)calloc((yyleng + 1), sizeof(char));

    int j = 0;
    int len = yyleng - 1;
    for (int i = 1; i < len; i++) {
        if (yytext[i] == '\\' && i != len - 1) {
            switch(yytext[i + 1]) {
                case '\\':
                    newStr[j++] = '\\';
                    i++;
                    break;
                case 't':
                    newStr[j++] = '\t';
                    i++;
                    break;
                case 'n':
                    newStr[j++] = '\n';
                    i++;
                    break;
                case '"':
                    newStr[j++] = '"';
                    i++;
                    break;
                default:
                    printf("Error!");
                    exit(1);
            }
        }
        else {
            newStr[j++] = yytext[i];
        }
    }
    printf("<%s>", newStr);
    free(newStr);
}

float       {printf("double");}
{number}    {printf("%s", yytext);}
{id}        {printf("%s", yytext);}

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