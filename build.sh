#!/bin/bash

# Pitch++ Compiler - Linux/Mac Build Script
# Author: Abdullah Butt (L1F22BSCS0497)

echo "========================================"
echo "   Pitch++ Compiler - Build Script"
echo "========================================"
echo ""

# Check if Flex is installed
if ! command -v flex &> /dev/null; then
    echo "[ERROR] Flex not found! Please install flex."
    echo "Ubuntu/Debian: sudo apt-get install flex"
    echo "MacOS: brew install flex"
    exit 1
fi

# Check if GCC is installed
if ! command -v gcc &> /dev/null; then
    echo "[ERROR] GCC not found! Please install gcc."
    echo "Ubuntu/Debian: sudo apt-get install gcc"
    echo "MacOS: brew install gcc"
    exit 1
fi

echo "[1/3] Generating lexer from scanner.l..."
flex scanner.l
if [ $? -ne 0 ]; then
    echo "[ERROR] Flex generation failed!"
    exit 1
fi
echo "[OK] Lexer generated successfully."
echo ""

echo "[2/3] Compiling lexer..."
gcc -Wall -g lex.yy.c -o scanner
if [ $? -ne 0 ]; then
    echo "[ERROR] Compilation failed!"
    exit 1
fi
echo "[OK] Compilation successful."
echo ""

echo "[3/3] Running scanner on test_program.pitch..."
./scanner test_program.pitch
if [ $? -ne 0 ]; then
    echo "[ERROR] Scanner execution failed!"
    exit 1
fi
echo ""

echo "========================================"
echo "        Build Complete!"
echo "========================================"
echo ""
echo "Output files generated:"
echo "  - tokens.txt (tokenization results)"
echo "  - errors.log (error log)"
echo ""
echo "You can now:"
echo "  1. Check tokens.txt for token output"
echo "  2. Run: ./scanner yourfile.pitch"
echo "  3. Test with: ./scanner error_test.pitch"
echo ""

