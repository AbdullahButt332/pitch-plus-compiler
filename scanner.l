%{
/*
 * Pitch++ Lexical Analyzer
 * A Cricket-themed C++ Compiler
 * Author: Abdullah Butt (L1F22BSCS0497)
 * 
 * This lexical analyzer tokenizes Pitch++ source code
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line_num = 1;
FILE *token_file;
FILE *error_file;
int error_count = 0;

void print_token(const char* token_type, const char* lexeme) {
    printf("Line %d: %s → %s\n", line_num, token_type, lexeme);
    fprintf(token_file, "Line %d: %s → %s\n", line_num, token_type, lexeme);
}

void print_error(const char* lexeme) {
    printf("Line %d: ERROR → %s (invalid token)\n", line_num, lexeme);
    fprintf(error_file, "Line %d: ERROR → %s (invalid token)\n", line_num, lexeme);
    error_count++;
}

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

    /* Keywords - Cricket Themed */
"OPENER"        { print_token("KEYWORD", yytext); }
"ALLROUNDER"    { print_token("KEYWORD", yytext); }
"PLAY"          { print_token("KEYWORD", yytext); }
"LEGALBALL"     { print_token("KEYWORD", yytext); }
"NOBALL"        { print_token("KEYWORD", yytext); }
"RETIRE"        { print_token("KEYWORD", yytext); }
"OUT"           { print_token("KEYWORD", yytext); }
"NOTOUT"        { print_token("KEYWORD", yytext); }
"TOSS"          { print_token("KEYWORD", yytext); }
"UMPIRE"        { print_token("KEYWORD", yytext); }
"INNING"        { print_token("KEYWORD", yytext); }
"OVER"          { print_token("KEYWORD", yytext); }
"RUN"           { print_token("KEYWORD", yytext); }
"TEAM"          { print_token("KEYWORD", yytext); }
"TEXTBOOK"      { print_token("KEYWORD", yytext); }

    /* Identifiers (Only uppercase letters and digits) */
{IDENTIFIER}    { print_token("IDENTIFIER", yytext); }

    /* Numbers (Integers and Floats) */
{NUMBER}        { print_token("NUMBER", yytext); }

    /* Operators */
"+"             { print_token("OPERATOR", yytext); }
"-"             { print_token("OPERATOR", yytext); }
"*"             { print_token("OPERATOR", yytext); }
"/"             { print_token("OPERATOR", yytext); }
"==="           { print_token("OPERATOR", yytext); }
"!=="           { print_token("OPERATOR", yytext); }
"="             { print_token("OPERATOR", yytext); }
"+++"           { print_token("OPERATOR", yytext); }
"---"           { print_token("OPERATOR", yytext); }
"<="            { print_token("OPERATOR", yytext); }
">="            { print_token("OPERATOR", yytext); }
"<"             { print_token("OPERATOR", yytext); }
">"             { print_token("OPERATOR", yytext); }

    /* Punctuations */
"~"             { print_token("PUNCTUATION", yytext); }
"{"             { print_token("PUNCTUATION", yytext); }
"}"             { print_token("PUNCTUATION", yytext); }
"("             { print_token("PUNCTUATION", yytext); }
")"             { print_token("PUNCTUATION", yytext); }
","             { print_token("PUNCTUATION", yytext); }
";"             { print_token("PUNCTUATION", yytext); }

    /* Strings and Characters */
{STRING}        { print_token("STRING", yytext); }
{CHAR}          { print_token("CHAR", yytext); }

    /* Comments (ignored, but line numbers tracked) */
{SINGLE_COMMENT}    { /* Single line comment - ignore */ }
{MULTI_COMMENT}     { 
                        /* Multi-line comment - count newlines */
                        for(int i = 0; i < yyleng; i++) {
                            if(yytext[i] == '\n') line_num++;
                        }
                    }

    /* Whitespace (ignored) */
{WHITESPACE}    { /* Ignore whitespace */ }

    /* Newline (track line numbers) */
{NEWLINE}       { line_num++; }

    /* Invalid tokens - Error handling */
[a-z]+          { print_error(yytext); /* lowercase identifiers not allowed */ }
[0-9]+{LETTER_UPPER}+   { print_error(yytext); /* invalid identifier starting with number */ }
[@#$%^&|\\]+    { print_error(yytext); /* invalid special characters */ }
.               { print_error(yytext); /* any other invalid character */ }

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Error: Cannot open file '%s'\n", argv[1]);
        return 1;
    }

    token_file = fopen("tokens.txt", "w");
    error_file = fopen("errors.log", "w");
    
    if (!token_file || !error_file) {
        printf("Error: Cannot create output files\n");
        return 1;
    }

    printf("=== Pitch++ Lexical Analyzer ===\n");
    printf("Analyzing: %s\n\n", argv[1]);
    fprintf(token_file, "=== Pitch++ Lexical Analyzer Output ===\n");
    fprintf(token_file, "Input File: %s\n\n", argv[1]);

    yyin = input_file;
    yylex();

    printf("\n=== Analysis Complete ===\n");
    printf("Total lines processed: %d\n", line_num - 1);
    printf("Errors found: %d\n", error_count);
    
    fprintf(token_file, "\n=== Analysis Complete ===\n");
    fprintf(token_file, "Total lines: %d\n", line_num - 1);
    fprintf(token_file, "Errors: %d\n", error_count);

    if (error_count == 0) {
        fprintf(error_file, "No errors found.\n");
    }

    fclose(input_file);
    fclose(token_file);
    fclose(error_file);

    printf("\nOutputs generated:\n");
    printf("  - tokens.txt (tokenization results)\n");
    printf("  - errors.log (error log)\n");

    return 0;
}

