%{
  #include <stdio.h>
  #include <stdlib.h>
%}

%token T_DO
%token T_WHILE
%token T_LOOP
%token T_EXIT
%token T_ENDDO

%token T_COMMAND

%token T_ID

%token T_NUM_LITERAL
%token T_STR_LITERAL

%token T_LOGICAL_OP

%left '+' '-'
%left '*' '/'

%%

command : 
        T_DO T_WHILE logical_expr vfp_command loop_opt exit_opt T_ENDDO
        ;

logical_expr  :
              operand_l T_LOGICAL_OP operand_l
              ;

operand_l  :
           T_STR_LITERAL
           | T_ID
           | expr_a
           ;

expr_a  :
        T_NUM_LITERAL
        | expr_a '+' expr_a
        | expr_a '-' expr_a
        | expr_a '*' expr_a
        | expr_a '/' expr_a
        ;

vfp_command :
            T_COMMAND
            ;


loop_opt  :
          | T_LOOP
          ;

exit_opt  :
          | T_EXIT
          ;

%%

int yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
  return 0;
}

int main(void) {
  if (yyparse() == 0)
    printf("no syntax error\n");
  return 0;
}
