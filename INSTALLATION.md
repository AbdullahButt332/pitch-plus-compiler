# Pitch++ Compiler - Installation Guide

## Prerequisites Installation

This guide will help you install the necessary tools to compile and run the Pitch++ compiler.

---

## Windows Installation

### Method 1: Using Chocolatey (Recommended)

1. **Install Chocolatey** (if not already installed):
   - Open PowerShell as Administrator
   - Run:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. **Install Flex and GCC**:
   ```powershell
   choco install winflexbison3 -y
   choco install mingw -y
   ```

3. **Verify installation**:
   ```powershell
   win_flex --version
   gcc --version
   ```

### Method 2: Manual Installation

1. **Install WinFlexBison**:
   - Download from: https://github.com/lexxmark/winflexbison/releases
   - Extract to `C:\winflexbison`
   - Add `C:\winflexbison` to system PATH

2. **Install MinGW-w64**:
   - Download from: https://www.mingw-w64.org/downloads/
   - Or use: https://github.com/niXman/mingw-builds-binaries/releases
   - Install to `C:\mingw64`
   - Add `C:\mingw64\bin` to system PATH

3. **Verify installation**:
   - Open new Command Prompt
   - Run: `win_flex --version`
   - Run: `gcc --version`

### Adding to PATH (Windows)

1. Right-click "This PC" → Properties
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "System variables", find "Path"
5. Click "Edit" → "New"
6. Add the directories:
   - `C:\winflexbison`
   - `C:\mingw64\bin`
7. Click OK to save
8. Restart Command Prompt/PowerShell

---

## Linux Installation

### Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install flex gcc make -y
```

### Fedora / RHEL / CentOS

```bash
sudo dnf install flex gcc make -y
# Or on older systems:
sudo yum install flex gcc make -y
```

### Arch Linux

```bash
sudo pacman -S flex gcc make
```

### Verify Installation

```bash
flex --version
gcc --version
make --version
```

---

## MacOS Installation

### Using Homebrew (Recommended)

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install tools**:
   ```bash
   brew install flex gcc make
   ```

3. **Verify installation**:
   ```bash
   flex --version
   gcc --version
   make --version
   ```

---

## Building the Project

Once you have installed the prerequisites:

### Windows

```cmd
cd pitch-plus-compiler
build.bat
```

### Linux / Mac

```bash
cd pitch-plus-compiler
chmod +x build.sh
./build.sh
```

### Using Make (All Platforms)

```bash
cd pitch-plus-compiler
make
make run
```

---

## Testing the Installation

Create a simple test file `hello.pitch`:

```pitch
PLAY() {
    RUN("Hello Pitch++!")~
    RETIRE 0~
}
```

Run the scanner:

### Windows
```cmd
scanner.exe hello.pitch
```

### Linux/Mac
```bash
./scanner hello.pitch
```

Check the output:
```bash
cat tokens.txt
```

Expected output:
```
Line 1: KEYWORD → PLAY
Line 1: PUNCTUATION → (
Line 1: PUNCTUATION → )
Line 1: PUNCTUATION → {
Line 2: KEYWORD → RUN
...
```

---

## Troubleshooting

### Windows: "win_flex is not recognized"

**Solution**: Flex is not in PATH
1. Find where WinFlexBison is installed
2. Add that directory to system PATH (see above)
3. Restart Command Prompt

### Windows: "gcc is not recognized"

**Solution**: MinGW is not in PATH
1. Find where MinGW is installed (usually `C:\mingw64\bin`)
2. Add to system PATH
3. Restart Command Prompt

### Linux/Mac: "flex: command not found"

**Solution**: Install flex
```bash
# Ubuntu/Debian
sudo apt-get install flex

# MacOS
brew install flex
```

### Linux/Mac: "Permission denied: ./scanner"

**Solution**: Make the file executable
```bash
chmod +x scanner
./scanner test_program.pitch
```

### Build error: "undefined reference to `yywrap`"

**Solution**: This should not happen with our scanner.l as it defines yywrap.
If it does, add `-lfl` flag to gcc:
```bash
gcc lex.yy.c -o scanner -lfl
```

---

## Alternative: Online Compilers

If you cannot install locally, you can use online C compilers:

1. Generate the C code locally:
   ```bash
   flex scanner.l
   ```

2. Copy the content of `lex.yy.c`

3. Use online compiler like:
   - OnlineGDB: https://www.onlinegdb.com/online_c_compiler
   - Replit: https://replit.com/
   - JDoodle: https://www.jdoodle.com/c-online-compiler

4. Paste the code and run with your test file

---

## Next Steps

After successful installation:

1. Read `README.md` for project overview
2. Check `QUICKSTART.md` for quick start guide
3. Run `make run` to test the scanner
4. View `tokens.txt` for output
5. Try `error_test.pitch` to see error handling

---

## Support

For issues:
- Check the troubleshooting section above
- Review the error messages carefully
- Ensure all tools are in PATH
- Try reinstalling the tools

---

**Good luck with your Pitch++ compiler!** 🏏

