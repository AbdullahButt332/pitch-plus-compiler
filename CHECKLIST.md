# Pitch++ Compiler Project Checklist

## ✅ Assignment Requirements Checklist

### 1. Lexical Analyzer Implementation
- [x] Scanner using Flex (scanner.l)
- [x] Tokenization of all token types
- [x] Line number tracking
- [x] Error handling and reporting
- [x] Output format: `Line <n>: <TOKEN_TYPE> → <lexeme>`

### 2. Token Categories (All Implemented)
- [x] Identifiers (uppercase only: [A-Z]([A-Z]|[0-9])*)
- [x] Numbers (integers, floats with signs)
- [x] Keywords (15 cricket-themed keywords)
- [x] Operators (13 operators)
- [x] Punctuations (7 punctuations)
- [x] Strings and Characters
- [x] Comments (single-line and multi-line)

### 3. Uniqueness Requirements
- [x] 15+ unique keywords (Cricket-themed)
- [x] 3+ unique operators (13 total)
- [x] 2+ unique punctuations (7 total)
- [x] Unique test program (20+ lines) - test_program.pitch
- [x] Original design (cricket theme)

### 4. Documentation
- [x] PDF documentation content (DOCUMENTATION.txt)
- [x] Regex definitions table
- [x] Finite Automata diagrams (included in documentation)
- [x] Explanation of 15 keywords with reasoning
- [x] Operators and punctuations documented

### 5. Deliverables
- [x] scanner.l (Flex file)
- [x] test_program.pitch (20+ lines of Pitch++ code)
- [x] README.md (comprehensive guide)
- [x] .gitignore (for clean repository)
- [x] Makefile (for easy compilation)
- [x] QUICKSTART.md (quick start guide)
- [x] VIDEO_DEMO_SCRIPT.sh (demo guide)
- [x] EXPECTED_OUTPUT.txt (sample output)
- [ ] tokens.txt (generated after compilation)
- [ ] errors.log (generated after compilation)

### 6. Demo Video Requirements (Guide Provided)
- [x] Demo script created (VIDEO_DEMO_SCRIPT.sh)
- [ ] Record 5-minute video (User to do)
- [ ] Demonstrate scanner running
- [ ] Explain 2+ regex patterns
- [ ] Show error handling example
- [ ] Upload to repository

### 7. GitHub Repository
- [x] All files organized
- [x] Clean structure
- [x] Documentation included
- [ ] Create GitHub repository (User to do)
- [ ] Push all files (User to do)
- [ ] Add README.md as main documentation
- [ ] Submit GitHub link

---

## 📋 Keywords Summary (15 Total)

1. OPENER (int)
2. ALLROUNDER (float)
3. PLAY (main)
4. LEGALBALL (true)
5. NOBALL (false)
6. RETIRE (return)
7. OUT (break)
8. NOTOUT (continue)
9. TOSS (if)
10. UMPIRE (else)
11. INNING (while)
12. OVER (for)
13. RUN (cout/print)
14. TEAM (class)
15. TEXTBOOK (string)

---

## 🔧 Operators (13 Total)

+, -, *, /, ===, !==, =, +++, ---, <, >, <=, >=

---

## 📌 Punctuations (7 Total)

~, {, }, (, ), ,, ;

---

## 🎯 What Makes This Project Unique?

1. **Cricket Theme**: All keywords relate to cricket terminology
2. **Cultural Connection**: Makes programming relatable for cricket fans
3. **Intuitive Mapping**: Each keyword has a logical connection to its function
4. **Statement Terminator**: Uses ~ instead of semicolon
5. **Triple Operators**: +++ and --- (cricket boundaries theme)
6. **Equality Operator**: === (triple equals)
7. **Complete Documentation**: Comprehensive guides and examples

---

## 🚀 Next Steps for Student

### Immediate Tasks:
1. **Install Tools**
   - Install Flex (WinFlexBison on Windows)
   - Install GCC (MinGW on Windows)
   - Install Make

2. **Test the Scanner**
   ```bash
   cd pitch-plus-compiler
   make
   make run
   ```

3. **Verify Output**
   - Check tokens.txt
   - Check errors.log
   - Verify line numbers match

4. **Create GitHub Repository**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Pitch++ Compiler Phase 1"
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

5. **Record Demo Video**
   - Follow VIDEO_DEMO_SCRIPT.sh
   - Keep it under 5 minutes
   - Show all required segments
   - Upload to repository or YouTube

6. **Create PDF Documentation**
   - Convert DOCUMENTATION.txt to PDF
   - Or create PDF from README.md
   - Include finite automata diagrams (photos from notebook)
   - Add to repository

7. **Final Submission**
   - Submit GitHub repository link
   - Upload PDF documentation separately
   - Ensure video is accessible
   - Double-check all files are present

---

## ⚠️ Important Reminders

- **Do NOT copy** keywords or code from classmates
- **Do NOT use** ChatGPT-generated test programs as-is
- **Ensure** all files are in the repository
- **Test** the scanner before submission
- **Include** at least one error handling example
- **Verify** all keywords appear in test program
- **Keep** demo video under 5 minutes
- **Submit** GitHub link, not ZIP file

---

## 📝 Grading Criteria (Anticipated)

- Lexical analyzer functionality: 30%
- Token recognition accuracy: 20%
- Error handling: 15%
- Documentation quality: 15%
- Code originality: 10%
- Demo video: 10%

---

## 🏏 Good Luck!

**May your code compile without errors, and your innings be long!**

---

Project Created: November 2025
Author: Abdullah Butt (L1F22BSCS0497)
Language: Pitch++ (Cricket-themed C++)

