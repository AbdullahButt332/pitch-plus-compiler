# Pitch++ Compiler - Phase 2 Documentation
**Syntax Analyzer (Parser)**

**Author:** Abdullah Butt  
**Registration ID:** L1F22BSCS0497  
**Course:** Compiler Construction  
**Phase:** 2 - Syntax Analysis

---

## 1. Language Overview

### Purpose of Pitch++
Pitch++ is a cricket-themed programming language designed to make programming more engaging and relatable for cricket enthusiasts. It maintains C++-like structure while using cricket terminology for keywords and constructs.

### Style of Syntax
- **Block-based:** Uses `{` `}` for code blocks
- **Statement terminator:** Uses `~` (tilde) instead of semicolon
- **Type declarations:** Cricket-position-based types (OPENER, ALLROUNDER, TEXTBOOK)
- **Control flow:** Cricket-action keywords (TOSS, OVER, INNING)

### Why These Keywords?

| Category | Keyword | Reason |
|----------|---------|--------|
| Data Type | OPENER | Opening batsman → Integer (solid foundation) |
| Data Type | ALLROUNDER | Versatile player → Float (decimal flexibility) |
| Data Type | TEXTBOOK | Classic shots → String (text) |
| Control | TOSS | Match decision point → if statement |
| Control | OVER | 6-ball unit → for loop (fixed iterations) |
| Control | INNING | Match phase → while loop |
| Action | RUN | Scoring → Output statement |
| Action | RETIRE | Batsman leaves → Return statement |

### Selected Tokens from Phase 1

**5 Keywords:**
1. PLAY - main function
2. TOSS - if statement  
3. OVER - for loop
4. INNING - while loop
5. RUN - output statement

**3 Operators:**
1. `=` - Assignment
2. `===` - Equality check
3. `+++` - Increment

**2 Punctuations:**
1. `~` - Statement terminator
2. `{}` - Block delimiters

---

## 2. Grammar Definition (Context-Free Grammar)

### Complete CFG for Pitch++

```
<program> → PLAY ( ) { <stmt_list> }
          | PLAY ( ) { }

<stmt_list> → <stmt> <stmt_list>
            | <stmt>

<stmt> → <declaration_stmt>
       | <assignment_stmt>
       | <conditional_stmt>
       | <loop_stmt>
       | <output_stmt>
       | <return_stmt>
       | <control_stmt>
       | <class_stmt>

<declaration_stmt> → OPENER IDENTIFIER = <expr> ~
                   | ALLROUNDER IDENTIFIER = <expr> ~
                   | TEXTBOOK IDENTIFIER = STRING ~
                   | OPENER IDENTIFIER ~
                   | ALLROUNDER IDENTIFIER ~

<assignment_stmt> → IDENTIFIER = <expr> ~
                  | IDENTIFIER +++ ~
                  | IDENTIFIER --- ~

<conditional_stmt> → TOSS ( <condition> ) { <stmt_list> }
                   | TOSS ( <condition> ) { <stmt_list> } UMPIRE { <stmt_list> }

<loop_stmt> → OVER ( <assignment_expr> ~ <condition> ~ <update_expr> ) { <stmt_list> }
            | INNING ( <condition> ) { <stmt_list> }

<output_stmt> → RUN ( STRING ) ~
              | RUN ( IDENTIFIER ) ~
              | RUN ( NUMBER ) ~

<return_stmt> → RETIRE <expr> ~
              | RETIRE ~

<control_stmt> → OUT ~
               | NOTOUT ~

<class_stmt> → TEAM IDENTIFIER { <stmt_list> }

<condition> → <expr> === <expr>
            | <expr> !== <expr>
            | <expr> < <expr>
            | <expr> > <expr>
            | <expr> <= <expr>
            | <expr> >= <expr>

<expr> → <expr> + <term>
       | <expr> - <term>
       | <term>

<term> → <term> * <factor>
       | <term> / <factor>
       | <factor>

<factor> → NUMBER
         | IDENTIFIER
         | LEGALBALL
         | NOBALL
         | ( <expr> )

<assignment_expr> → OPENER IDENTIFIER = <expr>
                  | IDENTIFIER = <expr>

<update_expr> → IDENTIFIER +++
              | IDENTIFIER ---
```

---

## 3. Sample Production Rules (10 Rules)

### Rule 1: Program Start
```
<program> → PLAY ( ) { <stmt_list> }
```
**Explanation:** Every Pitch++ program must start with PLAY() followed by statements in braces.

### Rule 2: Variable Declaration
```
<declaration_stmt> → OPENER IDENTIFIER = <expr> ~
```
**Explanation:** Declares an integer variable (OPENER) with initialization.

### Rule 3: Assignment
```
<assignment_stmt> → IDENTIFIER = <expr> ~
```
**Explanation:** Assigns a value to an existing variable.

### Rule 4: If Statement
```
<conditional_stmt> → TOSS ( <condition> ) { <stmt_list> }
```
**Explanation:** Conditional branching using TOSS (like toss decision in cricket).

### Rule 5: For Loop
```
<loop_stmt> → OVER ( <assignment_expr> ~ <condition> ~ <update_expr> ) { <stmt_list> }
```
**Explanation:** Fixed iteration loop using OVER (like overs in cricket).

### Rule 6: While Loop
```
<loop_stmt> → INNING ( <condition> ) { <stmt_list> }
```
**Explanation:** Conditional loop using INNING (continues until condition fails).

### Rule 7: Output Statement
```
<output_stmt> → RUN ( STRING ) ~
```
**Explanation:** Prints output using RUN keyword (scoring runs).

### Rule 8: Return Statement
```
<return_stmt> → RETIRE <expr> ~
```
**Explanation:** Returns from function using RETIRE (batsman retiring).

### Rule 9: Expression
```
<expr> → <expr> + <term>
```
**Explanation:** Arithmetic expression with left-associativity.

### Rule 10: Class Definition
```
<class_stmt> → TEAM IDENTIFIER { <stmt_list> }
```
**Explanation:** Defines a class using TEAM keyword (cricket team structure).

---

## 4. FIRST and FOLLOW Sets

### Non-Terminal 1: `<declaration_stmt>`

**FIRST(<declaration_stmt>):**
```
FIRST(<declaration_stmt>) = { OPENER, ALLROUNDER, TEXTBOOK }
```

**Step-by-step derivation:**
1. Rule: `<declaration_stmt> → OPENER IDENTIFIER = <expr> ~`
   - FIRST includes: **OPENER**
2. Rule: `<declaration_stmt> → ALLROUNDER IDENTIFIER = <expr> ~`
   - FIRST includes: **ALLROUNDER**
3. Rule: `<declaration_stmt> → TEXTBOOK IDENTIFIER = STRING ~`
   - FIRST includes: **TEXTBOOK**

**FOLLOW(<declaration_stmt>):**
```
FOLLOW(<declaration_stmt>) = { OPENER, ALLROUNDER, TEXTBOOK, IDENTIFIER, 
                               TOSS, OVER, INNING, RUN, RETIRE, OUT, NOTOUT, 
                               TEAM, }, $ }
```

**Step-by-step derivation:**
1. `<declaration_stmt>` appears in `<stmt>` which appears in `<stmt_list>`
2. `<stmt_list> → <stmt> <stmt_list>` means anything in FIRST(<stmt>) can follow
3. `<stmt_list> → <stmt>` and `<stmt_list>` appears before `}` in program
4. Therefore FOLLOW includes all statement starters and `}`

---

### Non-Terminal 2: `<conditional_stmt>`

**FIRST(<conditional_stmt>):**
```
FIRST(<conditional_stmt>) = { TOSS }
```

**Step-by-step derivation:**
1. Rule: `<conditional_stmt> → TOSS ( <condition> ) { <stmt_list> }`
   - FIRST includes: **TOSS**
2. Rule: `<conditional_stmt> → TOSS ( <condition> ) { <stmt_list> } UMPIRE { <stmt_list> }`
   - FIRST includes: **TOSS**
3. Both productions start with TOSS

**FOLLOW(<conditional_stmt>):**
```
FOLLOW(<conditional_stmt>) = { OPENER, ALLROUNDER, TEXTBOOK, IDENTIFIER, 
                               TOSS, OVER, INNING, RUN, RETIRE, OUT, NOTOUT, 
                               TEAM, }, $ }
```

**Step-by-step derivation:**
1. `<conditional_stmt>` is a `<stmt>` in `<stmt_list>`
2. Another statement can follow (FIRST of all statement types)
3. Can be followed by `}` (end of block)
4. Can be at end of program ($)

---

## 5. Ambiguity Check

### Is the Grammar Ambiguous?

**Answer:** The grammar has **potential ambiguity** in the dangling-else problem.

### Ambiguous Construct:

```pitch
TOSS(X > 5) 
    TOSS(Y > 10) 
        RUN("A")~
UMPIRE 
    RUN("B")~
```

**Problem:** Does UMPIRE match with inner TOSS or outer TOSS?

### Two Possible Parse Trees:

**Interpretation 1:** UMPIRE matches inner TOSS
```
TOSS(X>5)
  └── TOSS(Y>10)
        ├── RUN("A")
        └── UMPIRE
              └── RUN("B")
```

**Interpretation 2:** UMPIRE matches outer TOSS
```
TOSS(X>5)
  ├── TOSS(Y>10)
  │     └── RUN("A")
  └── UMPIRE
        └── RUN("B")
```

### Resolution in Implementation:

**Strategy:** Use **shift-reduce conflict resolution** in YACC/Bison
- By default, Bison uses "shift" preference
- This means UMPIRE matches the **closest TOSS** (inner one)
- This is the expected behavior in most languages
- Can also enforce proper bracing: require `{}` for all blocks

---

## 6. Parse Tree Construction

### Valid Program Fragment:

```pitch
PLAY() {
    OPENER SCORE = 0~
    SCORE = SCORE + 10~
    TOSS(SCORE > 5) {
        RUN("High score")~
    }
}
```

### Parse Tree:

```
                    <program>
                       |
        PLAY ( ) { <stmt_list> }
                       |
            +----------+----------+
            |          |          |
        <stmt>     <stmt>     <stmt>
            |          |          |
    <declaration>  <assign>  <conditional>
            |          |          |
    OPENER IDENTIFIER  IDENTIFIER TOSS(<condition>)
           |  = <expr>  = <expr>      {<stmt_list>}
      SCORE     |         |                |
              NUMBER  <expr>+<term>      <stmt>
               0        |     |            |
                    IDENTIFIER NUMBER  <output_stmt>
                    SCORE      10          |
                                     RUN(STRING)
                                          |
                                    "High score"
```

### Detailed Explanation:

1. **Root:** `<program>` starts with PLAY() and contains statement list
2. **First child:** Declaration of OPENER variable SCORE initialized to 0
3. **Second child:** Assignment statement adding 10 to SCORE
4. **Third child:** Conditional TOSS statement checking if SCORE > 5
5. **Inside TOSS:** Output statement printing "High score"

---

## 7. Error Scenarios

### Error Scenario 1: Missing Statement Terminator

**Incorrect Code:**
```pitch
PLAY() {
    OPENER RUNS = 50
    RUN("Score")~
}
```

**Error Details:**
- **Line where error occurs:** Line 2
- **Grammar rule violated:** `<declaration_stmt> → OPENER IDENTIFIER = <expr> ~`
- **Expected token:** `~` (tilde statement terminator)
- **Found token:** `RUN` (parser finds keyword instead of terminator)
- **Error message:** "Syntax error at line 2: Expected '~' before 'RUN'"

---

### Error Scenario 2: Missing Closing Parenthesis in Condition

**Incorrect Code:**
```pitch
PLAY() {
    OPENER X = 10~
    TOSS(X > 5 {
        RUN("Valid")~
    }
}
```

**Error Details:**
- **Line where error occurs:** Line 3
- **Grammar rule violated:** `<conditional_stmt> → TOSS ( <condition> ) { <stmt_list> }`
- **Expected token:** `)` (closing parenthesis)
- **Found token:** `{` (opening brace found instead)
- **Error message:** "Syntax error at line 3: Expected ')' before '{'"

---

## 8. Integration with Phase 1

### Token Reuse:
All 15 keywords from Phase 1 are declared in parser.y using `%token`:
```c
%token OPENER ALLROUNDER PLAY LEGALBALL NOBALL
%token RETIRE OUT NOTOUT TOSS UMPIRE
%token INNING OVER RUN TEAM TEXTBOOK
```

### Operators from Phase 1:
```c
%token PLUS MINUS MULTIPLY DIVIDE EQUALS
%token EQUAL_EQUAL NOT_EQUAL INCREMENT DECREMENT
%token LESS_THAN GREATER_THAN LESS_EQUAL GREATER_EQUAL
```

### Punctuations from Phase 1:
```c
%token TILDE LBRACE RBRACE LPAREN RPAREN COMMA SEMICOLON
```

---

## 9. Parser Implementation Details

### Tools Used:
- **YACC/Bison:** Parser generator
- **Flex:** Lexical analyzer (from Phase 1)
- **GCC:** C compiler

### Compilation Flow:
```
scanner_integrated.l  ─┐
                       ├──> flex ──> lex.yy.c ─┐
parser.y              ─┘                        ├──> gcc ──> parser.exe
                                                │
                       bison ──> y.tab.c ───────┘
                              └> y.tab.h
```

### Error Handling:
- **Syntax errors:** Reported with line number and near token
- **Recovery:** Uses error productions to continue parsing
- **Output:** Clear success/failure message with error count

---

## 10. Test Results

### Valid Program Output:
```
=== Pitch++ Syntax Analyzer (Phase 2) ===
Analyzing: valid_program.pitch

--- Parsing Progress ---
✓ Integer declaration: 7
✓ Integer declaration: 8
✓ Integer declaration: 9
✓ Float declaration: 10
✓ String declaration: 11
✓ Output string: 14
...
✅ SYNTAX ANALYSIS SUCCESSFUL
   No syntax errors found!
   Program is grammatically correct.
```

### Invalid Program Output:
```
=== Pitch++ Syntax Analyzer (Phase 2) ===
Analyzing: invalid_program.pitch

--- Parsing Progress ---
❌ SYNTAX ERROR at Line 6: syntax error
   Near token: 'RUN'
❌ SYNTAX ERROR at Line 9: syntax error  
   Near token: '{'
...
❌ SYNTAX ANALYSIS FAILED
   Total errors found: 4
   Program has syntax errors.
```

---

## Conclusion

This Phase 2 implementation successfully:
- ✅ Defines complete CFG for Pitch++ language
- ✅ Computes FIRST and FOLLOW sets
- ✅ Identifies and resolves ambiguity
- ✅ Constructs parse trees for valid programs
- ✅ Detects and reports syntax errors with line numbers
- ✅ Integrates seamlessly with Phase 1 lexical analyzer
- ✅ Maintains cricket-themed language consistency

**Next Phase:** Semantic analysis and code generation

---

**Date:** January 2026  
**Status:** Phase 2 Complete ✅
