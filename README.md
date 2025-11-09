# Pitch++ Compiler - Lexical Analyzer

**Author:** Abdullah Butt  
**Registration ID:** L1F22BSCS0497  
**Course:** Compiler Construction  
**Assignment:** Phase 1 - Lexical Analysis

---

## Table of Contents
1. [Introduction](#introduction)
2. [Language Overview](#language-overview)
3. [Regex Definitions](#regex-definitions)
4. [Keywords Explanation](#keywords-explanation)
5. [Finite Automata Diagrams](#finite-automata-diagrams)
6. [Installation & Usage](#installation--usage)
7. [Sample Output](#sample-output)

---

## Introduction

**Pitch++** is a C++-like programming language inspired by cricket terminology. The goal is to make programming more engaging and relatable by mapping programming concepts to cricket terms that are familiar to cricket enthusiasts.

This lexical analyzer (scanner) tokenizes Pitch++ source code and produces:
- Token list with line numbers
- Error detection and reporting
- Comprehensive output files

---

## Language Overview

### Design Philosophy

Cricket is more than just a sport—it's a passion. **Pitch++** brings that passion into programming by using cricket terminology:

- **OVER** represents loops (overs in cricket)
- **PLAY** is the main function (playing the match)
- **OPENER**, **ALLROUNDER** are data types (player positions)
- **TOSS** is a conditional statement (toss in cricket)
- **RUN** outputs data (scoring runs)

This makes code more intuitive for cricket fans while maintaining the structure of C++.

---

## Regex Definitions

### Token Categories

| **Token Type** | **Regular Expression** | **Description** |
|----------------|------------------------|-----------------|
| **IDENTIFIER** | `[A-Z]([A-Z]|[0-9])*` | Only uppercase letters and digits, must start with letter |
| **INTEGER** | `[+-]?[0-9]+` | Optional sign followed by digits |
| **FLOAT** | `[+-]?[0-9]*\.[0-9]+` | Optional sign, optional digits, decimal point, required digits |
| **NUMBER** | `INTEGER \| FLOAT` | Either integer or float |
| **STRING** | `"([^"\n]|\\")*"` | Double-quoted strings with escape sequences |
| **CHAR** | `'([^'\n]|\\')' ` | Single-quoted character with escape sequences |
| **WHITESPACE** | `[ \t]+` | Spaces and tabs (ignored) |
| **NEWLINE** | `\n` | Line breaks (for line tracking) |
| **SINGLE_COMMENT** | `//.*` | Single-line comments |
| **MULTI_COMMENT** | `/*([^*]|\*+[^*/])*\*+/` | Multi-line comments |

---

## Keywords Explanation

### Cricket-Themed Keywords (15 Total)

| # | **Keyword** | **Equivalent** | **Explanation** | **Example** |
|---|-------------|----------------|-----------------|-------------|
| 1 | `OPENER` | `int` | Batsman who opens the innings → Integer variable | `OPENER score = 0~` |
| 2 | `ALLROUNDER` | `float` | Versatile player → Floating-point variable | `ALLROUNDER avg = 45.5~` |
| 3 | `PLAY` | `main` | The main match/function | `PLAY() { }` |
| 4 | `LEGALBALL` | `true` | A legal delivery in cricket → Boolean true | `LEGALBALL` |
| 5 | `NOBALL` | `false` | An illegal delivery → Boolean false | `NOBALL` |
| 6 | `RETIRE` | `return` | Batsman retires → Return statement | `RETIRE 0~` |
| 7 | `OUT` | `break` | Batsman is out → Break loop | `OUT~` |
| 8 | `NOTOUT` | `continue` | Batsman continues → Continue loop | `NOTOUT~` |
| 9 | `TOSS` | `if` | Toss decision → If statement | `TOSS(runs > 50) { }` |
| 10 | `UMPIRE` | `else` | Umpire's decision → Else statement | `UMPIRE { }` |
| 11 | `INNING` | `while` | Cricket innings → While loop | `INNING(wickets < 10) { }` |
| 12 | `OVER` | `for` | An over in cricket → For loop | `OVER(i=0~ i<6~ i+++) { }` |
| 13 | `RUN` | `cout/print` | Scoring runs → Output statement | `RUN("Score: ")~` |
| 14 | `TEAM` | `class` | Cricket team → Class definition | `TEAM Player { }` |
| 15 | `TEXTBOOK` | `string` | Textbook shots → String variable | `TEXTBOOK name = "Ali"~` |

### Why These Keywords?

These keywords were chosen to create a **direct mapping** between cricket concepts and programming constructs:
- **Action words** (PLAY, RUN, TOSS) → Actions in code
- **Player types** (OPENER, ALLROUNDER) → Data types
- **Match events** (OUT, NOTOUT, RETIRE) → Control flow
- **Match structure** (INNING, OVER) → Loop structures

This makes Pitch++ intuitive for anyone familiar with cricket!

---

## Operators & Punctuations

### Operators (13 Total)

| **Operator** | **Description** | **Example** |
|--------------|-----------------|-------------|
| `+` | Addition | `A + B` |
| `-` | Subtraction | `A - B` |
| `*` | Multiplication | `A * B` |
| `/` | Division | `A / B` |
| `===` | Equality check | `A === B` |
| `!==` | Not equal | `A !== B` |
| `=` | Assignment | `A = 10` |
| `+++` | Increment | `A+++` |
| `---` | Decrement | `A---` |
| `<` | Less than | `A < B` |
| `>` | Greater than | `A > B` |
| `<=` | Less than or equal | `A <= B` |
| `>=` | Greater than or equal | `A >= B` |

### Punctuations (7 Total)

| **Punctuation** | **Description** | **Usage** |
|-----------------|-----------------|-----------|
| `~` | Statement terminator | End of statement |
| `{` | Code block start | Start of block |
| `}` | Code block end | End of block |
| `(` | Function/expression start | Parameters, conditions |
| `)` | Function/expression end | Close parameters |
| `,` | Separator | List items |
| `;` | Alternative terminator | Alternate to `~` |

---

## Finite Automata Diagrams

### 1. Identifier Automaton

```
Identifiers: Only uppercase letters [A-Z], followed by uppercase letters or digits [0-9]

State Diagram:
    A-Z      A-Z, 0-9
(Start) ─────> (q1) ─────> ((Accept))
               │            ^
               └────────────┘
                A-Z, 0-9

Regex: [A-Z]([A-Z]|[0-9])*
```

### 2. Number Automaton (Integer & Float)

```
Numbers: Optional +/-, digits, optional decimal with more digits

Integer Path:
         +/-         0-9           0-9
(Start) ────> (q1) ────> (q2) ────> ((Accept))
         |              ^       ^
         └──────────────┘       │
                0-9             └── Loop

Float Path:
         +/-         0-9          .           0-9
(Start) ────> (q1) ────> (q2) ────> (q3) ────> ((Accept))
         |              ^                ^       ^
         └──────────────┘                └───────┘
                0-9                        0-9

Regex: [+-]?[0-9]+ | [+-]?[0-9]*\.[0-9]+
```

### 3. Operators Automaton

```
Operators: Single or multi-character operators

Examples:
+ : Simple acceptance
=== : Three equals in sequence
+++ : Three plus signs

State transitions shown in documentation finite automata diagram
```

---

## Installation & Usage

### Prerequisites

- **Flex** (Fast Lexical Analyzer Generator)
- **GCC** (GNU C Compiler)
- **Make** (Build automation tool)

### Windows Installation

```bash
# Install using Chocolatey (if available)
choco install winflexbison
choco install mingw

# Or install from:
# - Flex: https://github.com/lexxmark/winflexbison
# - GCC: https://www.mingw-w64.org/
```

### Linux/Mac Installation

```bash
# Ubuntu/Debian
sudo apt-get install flex gcc make

# MacOS
brew install flex gcc make
```

### Building the Scanner

```bash
# Clone or navigate to project directory
cd pitch-plus-compiler

# Build using Make
make

# Or build manually
flex scanner.l
gcc lex.yy.c -o scanner
```

### Running the Scanner

```bash
# Run on test program
make run

# Or run manually
./scanner test_program.pitch

# View outputs
cat tokens.txt
cat errors.log
```

---

## Sample Output

### Input Code (test_program.pitch - excerpt)

```pitch
PLAY() {
    OPENER TOTALRUNS = 0~
    OPENER TARGET = 150~
    TEXTBOOK TEAMNAME = "PAKISTAN"~
    
    OVER(OPENER I = 0~ I < 20~ I+++) {
        TOSS(WICKETS < 10) {
            RUN("Runs scored")~
        }
    }
    
    RETIRE 0~
}
```

### Output (tokens.txt - excerpt)

```
=== Pitch++ Lexical Analyzer Output ===
Input File: test_program.pitch

Line 5: KEYWORD → PLAY
Line 5: PUNCTUATION → (
Line 5: PUNCTUATION → )
Line 5: PUNCTUATION → {
Line 7: KEYWORD → OPENER
Line 7: IDENTIFIER → TOTALRUNS
Line 7: OPERATOR → =
Line 7: NUMBER → 0
Line 7: PUNCTUATION → ~
Line 8: KEYWORD → OPENER
Line 8: IDENTIFIER → TARGET
Line 8: OPERATOR → =
Line 8: NUMBER → 150
Line 8: PUNCTUATION → ~
...
```

### Error Handling Example

**Input with errors:**
```pitch
OPENER score = 10~
opener invalid = 5~    // lowercase - ERROR
OPENER 123ABC = 0~     // starts with number - ERROR
```

**Error output (errors.log):**
```
Line 2: ERROR → opener (invalid token)
Line 3: ERROR → 123 (invalid token)
```

---

## Project Structure

```
pitch-plus-compiler/
│
├── scanner.l              # Flex lexical analyzer specification
├── test_program.pitch     # Sample Pitch++ program (20+ lines)
├── Makefile              # Build automation
├── README.md             # This documentation
│
├── tokens.txt            # Generated token output
├── errors.log            # Generated error log
└── lex.yy.c              # Generated C code (from Flex)
```

---

## Features

✅ **15+ Cricket-themed keywords**  
✅ **13 Operators** (arithmetic, comparison, assignment, increment/decrement)  
✅ **7 Punctuations** (statement terminators, brackets)  
✅ **Line number tracking**  
✅ **Comprehensive error handling**  
✅ **String and character literal support**  
✅ **Single and multi-line comments**  
✅ **Uppercase-only identifier enforcement**  
✅ **Float and integer number support**

---

## Future Enhancements (Phase 2+)

- **Parser**: Build Abstract Syntax Tree (AST)
- **Semantic Analyzer**: Type checking and scope management
- **Code Generator**: Translate Pitch++ to C++ or machine code
- **Interpreter**: Direct execution of Pitch++ code
- **IDE Support**: Syntax highlighting and autocomplete

---

## Video Demo Guide

### 5-Minute Demo Structure

1. **Introduction (30 sec)**
   - Introduce Pitch++ and cricket-themed concept
   - Show project structure

2. **Code Walkthrough (1 min)**
   - Show `scanner.l` highlights
   - Explain 2 regex patterns (e.g., IDENTIFIER and NUMBER)

3. **Test Program (1 min)**
   - Walk through `test_program.pitch`
   - Highlight keywords and operators usage

4. **Running the Scanner (1.5 min)**
   - Compile: `make`
   - Run: `make run`
   - Show real-time tokenization output

5. **Error Handling Demo (1 min)**
   - Add intentional errors (lowercase identifier, invalid character)
   - Rerun scanner
   - Show error detection in `errors.log`

6. **Conclusion (30 sec)**
   - Summary of features
   - Future phases preview

---

## Author & License

**Created by:** Abdullah Butt (L1F22BSCS0497)  
**Course:** Compiler Construction - Phase 1  
**Institution:** [Your University]  
**Date:** November 2025

This project is created for educational purposes as part of the Compiler Construction course.

---

## Contact

For questions or collaboration:
- **GitHub:** [Your GitHub Profile]
- **Email:** [Your Email]

---

**May your code compile without errors, and your innings be long!** 🏏

