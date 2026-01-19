%{
/*
 * Pitch++ Syntax Analyzer (Parser)
 * A Cricket-themed C++ Compiler - Phase 2
 * Author: Abdullah Butt (L1F22BSCS0497)
 * 
 * This parser validates the grammatical structure of Pitch++ programs
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
extern int line_num;
extern char* yytext;

void yyerror(const char* s);
int error_count = 0;

%}

/* Token declarations from Phase 01 scanner */
%token OPENER ALLROUNDER PLAY LEGALBALL NOBALL
%token RETIRE OUT NOTOUT TOSS UMPIRE
%token INNING OVER RUN TEAM TEXTBOOK

%token IDENTIFIER NUMBER STRING CHAR

%token PLUS MINUS MULTIPLY DIVIDE
%token EQUALS EQUAL_EQUAL NOT_EQUAL
%token INCREMENT DECREMENT
%token LESS_THAN GREATER_THAN LESS_EQUAL GREATER_EQUAL

%token SEMICOLON TILDE LPAREN RPAREN LBRACE RBRACE COMMA

%start program

%%

/* Grammar Rules for Pitch++ Language */

/* Rule 1: Program Structure */
program
    : PLAY LPAREN RPAREN LBRACE stmt_list RBRACE
    | PLAY LPAREN RPAREN LBRACE RBRACE
    ;

/* Rule 2: Statement List */
stmt_list
    : stmt_list stmt
    | stmt
    ;

/* Rule 3: Statement Types */
stmt
    : declaration_stmt
    | assignment_stmt
    | conditional_stmt
    | loop_stmt
    | output_stmt
    | return_stmt
    | control_stmt
    | class_stmt
    | block_stmt
    | error TILDE
    {
        yyerror("Invalid statement syntax");
        yyerrok;
    }
    ;

/* Rule 4: Variable Declaration */
declaration_stmt
    : OPENER IDENTIFIER EQUALS expr TILDE
    | ALLROUNDER IDENTIFIER EQUALS expr TILDE
    | TEXTBOOK IDENTIFIER EQUALS STRING TILDE
    | OPENER IDENTIFIER TILDE
    | ALLROUNDER IDENTIFIER TILDE
    ;

/* Rule 5: Assignment Statement */
assignment_stmt
    : IDENTIFIER EQUALS expr TILDE
    | IDENTIFIER INCREMENT TILDE
    | IDENTIFIER DECREMENT TILDE
    ;

/* Rule 6: Conditional Statement (TOSS = if, UMPIRE = else) */
conditional_stmt
    : TOSS LPAREN condition RPAREN LBRACE stmt_list RBRACE
    | TOSS LPAREN condition RPAREN LBRACE stmt_list RBRACE UMPIRE LBRACE stmt_list RBRACE
    | TOSS LPAREN condition RPAREN LBRACE RBRACE
    ;

/* Rule 7: Loop Statements */
loop_stmt
    : OVER LPAREN assignment_expr TILDE condition TILDE update_expr RPAREN LBRACE stmt_list RBRACE
    | INNING LPAREN condition RPAREN LBRACE stmt_list RBRACE
    | OVER LPAREN assignment_expr TILDE condition TILDE update_expr RPAREN LBRACE RBRACE
    ;

/* Rule 8: Output Statement */
output_stmt
    : RUN LPAREN STRING RPAREN TILDE
    | RUN LPAREN IDENTIFIER RPAREN TILDE
    | RUN LPAREN NUMBER RPAREN TILDE
    ;

/* Rule 9: Return Statement */
return_stmt
    : RETIRE expr TILDE
    | RETIRE TILDE
    ;

/* Rule 10: Control Flow Statements */
control_stmt
    : OUT TILDE
    | NOTOUT TILDE
    ;

/* Rule 11: Class/Team Definition */
class_stmt
    : TEAM IDENTIFIER LBRACE stmt_list RBRACE
    | TEAM IDENTIFIER LBRACE RBRACE
    ;

/* Rule 12: Block Statement */
block_stmt
    : LBRACE stmt_list RBRACE
    ;

/* Rule 13: Conditions */
condition
    : expr EQUAL_EQUAL expr
    | expr NOT_EQUAL expr
    | expr LESS_THAN expr
    | expr GREATER_THAN expr
    | expr LESS_EQUAL expr
    | expr GREATER_EQUAL expr
    ;

/* Rule 14: Expressions */
expr
    : expr PLUS term
    | expr MINUS term
    | term
    ;

term
    : term MULTIPLY factor
    | term DIVIDE factor
    | factor
    ;

factor
    : NUMBER
    | IDENTIFIER
    | LEGALBALL
    | NOBALL
    | LPAREN expr RPAREN
    | STRING
    ;

/* Rule 15: Assignment Expression (for loops) */
assignment_expr
    : OPENER IDENTIFIER EQUALS expr
    | IDENTIFIER EQUALS expr
    ;

/* Rule 16: Update Expression (for loops) */
update_expr
    : IDENTIFIER INCREMENT
    | IDENTIFIER DECREMENT
    | IDENTIFIER EQUALS expr
    ;

%%

/* Error handling function */
void yyerror(const char* s) {
    fprintf(stderr, "SYNTAX ERROR at Line %d: %s\n", line_num, s);
    fprintf(stderr, "Near token: '%s'\n", yytext);
    error_count++;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file.pitch>\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Error: Cannot open file '%s'\n", argv[1]);
        return 1;
    }

    yyin = input_file;
    
    int parse_result = yyparse();
    
    if (parse_result == 0 && error_count == 0) {
        printf("SYNTAX ANALYSIS SUCCESSFUL\n");
    } else {
        printf("SYNTAX ANALYSIS FAILED\n");
    }
    
    fclose(input_file);
    return parse_result;
}
