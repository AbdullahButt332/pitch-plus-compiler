@echo off
REM Pitch++ Compiler - Windows Build Script
REM Author: Abdullah Butt (L1F22BSCS0497)

echo ========================================
echo    Pitch++ Compiler - Build Script
echo ========================================
echo.

REM Check if Flex is installed
where win_flex >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flex not found! Please install WinFlexBison.
    echo Download from: https://github.com/lexxmark/winflexbison/releases
    echo.
    pause
    exit /b 1
)

REM Check if GCC is installed
where gcc >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] GCC not found! Please install MinGW.
    echo Download from: https://www.mingw-w64.org/downloads/
    echo.
    pause
    exit /b 1
)

echo [1/3] Generating lexer from scanner.l...
win_flex scanner.l
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flex generation failed!
    pause
    exit /b 1
)
echo [OK] Lexer generated successfully.
echo.

echo [2/3] Compiling lexer...
gcc -Wall -g lex.yy.c -o scanner.exe
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed!
    pause
    exit /b 1
)
echo [OK] Compilation successful.
echo.

echo [3/3] Running scanner on test_program.pitch...
scanner.exe test_program.pitch
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Scanner execution failed!
    pause
    exit /b 1
)
echo.

echo ========================================
echo        Build Complete!
echo ========================================
echo.
echo Output files generated:
echo   - tokens.txt (tokenization results)
echo   - errors.log (error log)
echo.
echo You can now:
echo   1. Check tokens.txt for token output
echo   2. Run: scanner.exe yourfile.pitch
echo   3. Test with: scanner.exe error_test.pitch
echo.
pause

