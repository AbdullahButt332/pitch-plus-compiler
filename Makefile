# Makefile for Pitch++ Compiler
# Author: Abdullah Butt (L1F22BSCS0497)

# Compiler and tools
LEX = flex
CC = gcc
CFLAGS = -Wall -g

# Files
LEX_FILE = scanner.l
LEX_OUTPUT = lex.yy.c
EXECUTABLE = scanner
TEST_FILE = test_program.pitch

# Default target
all: $(EXECUTABLE)

# Build scanner
$(EXECUTABLE): $(LEX_FILE)
	@echo "Generating lexer from $(LEX_FILE)..."
	$(LEX) $(LEX_FILE)
	@echo "Compiling lexer..."
	$(CC) $(CFLAGS) $(LEX_OUTPUT) -o $(EXECUTABLE)
	@echo "Build complete! Executable: $(EXECUTABLE)"

# Run scanner on test program
run: $(EXECUTABLE)
	@echo "Running lexical analyzer on $(TEST_FILE)..."
	./$(EXECUTABLE) $(TEST_FILE)
	@echo ""
	@echo "Check tokens.txt and errors.log for output"

# Clean build files
clean:
	@echo "Cleaning build files..."
	rm -f $(LEX_OUTPUT) $(EXECUTABLE) $(EXECUTABLE).exe
	rm -f tokens.txt errors.log
	@echo "Clean complete!"

# Clean only output files
clean-output:
	@echo "Cleaning output files..."
	rm -f tokens.txt errors.log
	@echo "Output files cleaned!"

# Help
help:
	@echo "Pitch++ Compiler - Makefile Help"
	@echo "================================"
	@echo "Available targets:"
	@echo "  make         - Build the lexical analyzer"
	@echo "  make run     - Build and run on test_program.pitch"
	@echo "  make clean   - Remove all generated files"
	@echo "  make clean-output - Remove only output files"
	@echo "  make help    - Show this help message"

.PHONY: all run clean clean-output help

