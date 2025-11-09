# Pitch++ Compiler - Quick Start Guide

## Quick Start (For Testing)

### Prerequisites Check

Before you begin, ensure you have:

1. **Flex** (Lexical Analyzer Generator)
2. **GCC** (C Compiler)
3. **Make** (Build Tool)

### Installation Instructions

#### Windows (Using Chocolatey)
```powershell
choco install winflexbison3
choco install mingw
```

#### Windows (Manual)
- Download WinFlexBison: https://github.com/lexxmark/winflexbison/releases
- Download MinGW: https://www.mingw-w64.org/downloads/
- Add to PATH

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install flex gcc make
```

#### MacOS
```bash
brew install flex gcc make
```

### Build & Run

```bash
# Navigate to project directory
cd pitch-plus-compiler

# Build the scanner
make

# Run on test program
make run

# View outputs
cat tokens.txt
cat errors.log

# Clean build files
make clean
```

### Manual Build (if make doesn't work)

```bash
# Generate C code from Flex
flex scanner.l

# Compile the generated C code
gcc lex.yy.c -o scanner

# Run the scanner
./scanner test_program.pitch

# Or on Windows
scanner.exe test_program.pitch
```

### Expected Outputs

After running successfully, you should see:
- **tokens.txt** - Contains all recognized tokens with line numbers
- **errors.log** - Contains any errors found (should be empty for test_program.pitch)

### Verify Installation

Run this command to check if tools are installed:

```bash
# Check Flex
flex --version

# Check GCC
gcc --version

# Check Make
make --version
```

If all commands work, you're ready to build!

---

## Testing Your Own Pitch++ Code

Create a file with `.pitch` extension:

```pitch
PLAY() {
    OPENER SCORE = 100~
    TEXTBOOK NAME = "Pakistan"~
    RUN("Hello Cricket!")~
    RETIRE 0~
}
```

Run the scanner:
```bash
./scanner mycode.pitch
```

---

## Troubleshooting

### Error: "flex: command not found"
- Install Flex (see installation instructions above)

### Error: "gcc: command not found"
- Install GCC compiler (MinGW on Windows, gcc on Linux/Mac)

### Error: "Cannot open file"
- Ensure the input file exists
- Check file path and name

### Error: "Permission denied"
- On Linux/Mac, make the scanner executable: `chmod +x scanner`

---

## What's Next?

After Phase 1 (Lexical Analysis), the next phases will include:

- **Phase 2:** Parser (Syntax Analysis)
- **Phase 3:** Semantic Analysis
- **Phase 4:** Code Generation
- **Phase 5:** Optimization

---

For complete documentation, see README.md and DOCUMENTATION.txt

