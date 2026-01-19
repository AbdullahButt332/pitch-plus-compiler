%{
/*
 * Pitch++ Lexical Analyzer - Integrated with Parser
 * Phase 2 Integration
 */

#include "parser.tab.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line_num = 1;

%}

/* Regular Expression Definitions */
DIGIT           [0-9]
LETTER_UPPER    [A-Z]
IDENTIFIER      {LETTER_UPPER}({LETTER_UPPER}|{DIGIT})*
INTEGER         [+-]?{DIGIT}+
FLOAT           [+-]?{DIGIT}*\.{DIGIT}+
NUMBER          {INTEGER}|{FLOAT}
WHITESPACE      [ \t]+
NEWLINE         \n
STRING          \"([^\"\n]|\\\")*\"
CHAR            '([^'\n]|\\')'

/* Comments */
SINGLE_COMMENT  "//".*
MULTI_COMMENT   "/*"([^*]|\*+[^*/])*\*+"/"

%%

    /* Keywords - Return token codes */
"OPENER"        { return OPENER; }
"ALLROUNDER"    { return ALLROUNDER; }
"PLAY"          { return PLAY; }
"LEGALBALL"     { return LEGALBALL; }
"NOBALL"        { return NOBALL; }
"RETIRE"        { return RETIRE; }
"OUT"           { return OUT; }
"NOTOUT"        { return NOTOUT; }
"TOSS"          { return TOSS; }
"UMPIRE"        { return UMPIRE; }
"INNING"        { return INNING; }
"OVER"          { return OVER; }
"RUN"           { return RUN; }
"TEAM"          { return TEAM; }
"TEXTBOOK"      { return TEXTBOOK; }

    /* Identifiers */
{IDENTIFIER}    { return IDENTIFIER; }

    /* Numbers */
{NUMBER}        { return NUMBER; }

    /* Operators */
"+++"           { return INCREMENT; }
"---"           { return DECREMENT; }
"==="           { return EQUAL_EQUAL; }
"!=="           { return NOT_EQUAL; }
"<="            { return LESS_EQUAL; }
">="            { return GREATER_EQUAL; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }
"="             { return EQUALS; }
"<"             { return LESS_THAN; }
">"             { return GREATER_THAN; }

    /* Punctuations */
"~"             { return TILDE; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
","             { return COMMA; }
";"             { return SEMICOLON; }

    /* Strings */
{STRING}        { return STRING; }
{CHAR}          { return CHAR; }

    /* Comments (ignored) */
{SINGLE_COMMENT}    { /* Ignore */ }
{MULTI_COMMENT}     { 
                        for(int i = 0; i < yyleng; i++) {
                            if(yytext[i] == '\n') line_num++;
                        }
                    }

    /* Whitespace (ignored) */
{WHITESPACE}    { /* Ignore */ }

    /* Newline */
{NEWLINE}       { line_num++; }

    /* Invalid tokens */
.               { 
                    fprintf(stderr, "Lexical error at line %d: Unexpected character '%s'\n", 
                            line_num, yytext);
                }

%%

int yywrap() {
    return 1;
}
