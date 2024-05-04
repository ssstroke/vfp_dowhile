%{
  #include <stdio.h>
  #include <stdlib.h>

  #include "y.tab.h"
%}

%%

(?i:do)                     { return T_DO; }
(?i:while)                  { return T_WHILE; }
(?i:loop)                   { return T_LOOP; }
(?i:exit)                   { return T_EXIT; }
(?i:enddo)                  { return T_ENDDO; }

(?i:command)                { return T_COMMAND; }

[a-zA-Z_]([a-zA-Z_0-9])*    { return T_ID; }

[0-9]+              { return T_NUM_LITERAL; }
\"(\\.|[^"\\])*\"   { return T_STR_LITERAL; }

("<"|">"|"="|"<>"|"<="|">=")  { return T_LOGICAL_OP; }

"-"   return '-';
"+"   return '+';
"*"   return '*';
"/"   return '/';

[ \t\n]                     { ; }

.   { fprintf(stderr, "Unexpected symbol: %s\n", yytext); exit(EXIT_FAILURE); }

%%