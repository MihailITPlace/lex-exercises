%{
    #include<stdio.h>
    #define NUM 1
    #define ID 2
%}

delim     [ \t\n]
ws        {delim}+
letter    [A-Za-z]
digit     [0-9]
id        {letter}({letter}|{digit})*
number    {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
%%

{ws}      {/*none*/}
{id}      {printf("ID\n"); return(ID);}
{number}  {printf("NUM\n"); return(NUM);}

%%