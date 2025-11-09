# Git Setup and Submission Guide

## Step-by-Step Git & GitHub Setup

### 1. Install Git (if not already installed)

**Windows:**
```powershell
choco install git
# Or download from: https://git-scm.com/download/win
```

**Linux:**
```bash
sudo apt-get install git
```

**Mac:**
```bash
brew install git
```

---

### 2. Configure Git (First Time Only)

```bash
git config --global user.name "Abdullah Butt"
git config --global user.email "your-email@example.com"
```

---

### 3. Initialize Git Repository

```bash
# Navigate to project directory
cd C:\Users\hp\Desktop\pitch-plus-compiler

# Initialize git repository
git init

# Check status
git status
```

---

### 4. Create GitHub Repository

1. Go to https://github.com
2. Click "+" → "New repository"
3. Repository name: `pitch-plus-compiler`
4. Description: `Phase 1: Lexical Analyzer for Pitch++ - A Cricket-themed C++ Compiler`
5. **Make it PUBLIC** (required for submission)
6. **Do NOT** initialize with README (we already have one)
7. Click "Create repository"

---

### 5. Add and Commit Files

```bash
# Add all files
git add .

# Check what will be committed
git status

# Commit with meaningful message
git commit -m "feat: Initial commit - Pitch++ Compiler Phase 1 Lexical Analyzer

- Implemented Flex-based lexical analyzer for Pitch++
- Added 15 cricket-themed keywords (OPENER, PLAY, TOSS, etc.)
- Implemented 13 operators and 7 punctuations
- Created comprehensive test program (75+ lines)
- Added error handling with line number tracking
- Included complete documentation and guides
- Added build scripts for Windows/Linux/Mac

Project Features:
- Cricket-themed C++ programming language
- Uppercase-only identifier syntax
- Unique ~ statement terminator
- Triple operators (+++ and ---)
- Comprehensive error detection
- Cross-platform build support

Author: Abdullah Butt (L1F22BSCS0497)
Course: Compiler Construction - Phase 1
Assignment: Lexical Analysis using Flex"
```

---

### 6. Connect to GitHub and Push

```bash
# Add remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/pitch-plus-compiler.git

# Verify remote
git remote -v

# Create main branch and push
git branch -M main
git push -u origin main
```

**If you get authentication error:**

Option A: Use Personal Access Token (Recommended)
1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token with `repo` scope
3. Use token as password when pushing

Option B: Use GitHub CLI
```bash
# Install GitHub CLI
choco install gh  # Windows
brew install gh   # Mac

# Authenticate
gh auth login

# Then push
git push -u origin main
```

---

### 7. Verify Upload

1. Go to your GitHub repository: `https://github.com/YOUR_USERNAME/pitch-plus-compiler`
2. Verify all files are present
3. Check README.md is displayed nicely
4. Ensure repository is PUBLIC

---

### 8. Add Video Demo

**Option A: Upload to GitHub**
```bash
# If video is small (<100MB)
git add demo.mp4
git commit -m "docs: Add demo video"
git push
```

**Option B: Use GitHub Releases**
1. Go to repository → Releases → Create new release
2. Upload video as asset
3. Publish release
4. Add link to README

**Option C: External hosting**
1. Upload to YouTube (unlisted/public)
2. Or Google Drive (set to "anyone with link can view")
3. Add link in README.md:
```markdown
## Demo Video

Watch the 5-minute demo: [Click here](https://youtu.be/YOUR_VIDEO_ID)
```

```bash
git add README.md
git commit -m "docs: Add demo video link"
git push
```

---

### 9. Create Beautiful README on GitHub

Your README.md already has good formatting. To enhance it:

1. Add badges at the top (optional):
```markdown
![Language](https://img.shields.io/badge/Language-C-blue)
![Tool](https://img.shields.io/badge/Tool-Flex-green)
![Theme](https://img.shields.io/badge/Theme-Cricket-orange)
![Status](https://img.shields.io/badge/Status-Complete-success)
```

2. Add screenshots (optional):
```bash
# Take screenshots of:
# - Terminal running scanner
# - tokens.txt output
# - errors.log output

# Save as images/ folder
mkdir images
# Copy screenshots to images/

git add images/
git commit -m "docs: Add screenshots"
git push
```

3. Update README with images:
```markdown
## Sample Output

![Token Output](images/tokens-output.png)
```

---

### 10. Final Repository Structure

Your repository should look like:

```
pitch-plus-compiler/
│
├── README.md                    ⭐ Main documentation
├── scanner.l                    ⭐ Core lexer file
├── test_program.pitch           ⭐ Test program
├── tokens.txt                   ⭐ Output (generated)
├── errors.log                   ⭐ Error log (generated)
│
├── DOCUMENTATION.txt            📘 Detailed docs
├── INSTALLATION.md              📘 Installation guide
├── QUICKSTART.md                📘 Quick start
├── CHECKLIST.md                 📘 Project checklist
├── PROJECT_SUMMARY.md           📘 Project summary
├── EXPECTED_OUTPUT.txt          📘 Sample output
├── VIDEO_DEMO_SCRIPT.sh         📘 Video guide
│
├── Makefile                     🔧 Build file
├── build.bat                    🔧 Windows script
├── build.sh                     🔧 Linux/Mac script
├── .gitignore                   🔧 Git ignore
│
├── error_test.pitch             🧪 Error test
├── demo.mp4                     🎥 Video (or link in README)
└── GIT_GUIDE.md                 📋 This file
```

---

### 11. Update Repository Description

On GitHub repository page:
1. Click "About" gear icon (top right)
2. Add description: `Phase 1: Lexical Analyzer for Pitch++ - A Cricket-themed C++ Compiler`
3. Add topics: `compiler`, `lexical-analyzer`, `flex`, `cricket`, `cpp`, `education`
4. Save changes

---

### 12. Create Releases (Optional but Impressive)

```bash
# Tag the release
git tag -a v1.0 -m "Phase 1: Lexical Analyzer Complete"
git push origin v1.0
```

On GitHub:
1. Go to Releases → Create new release
2. Choose tag v1.0
3. Title: "Phase 1: Lexical Analyzer - Complete"
4. Description:
```markdown
## Pitch++ Compiler - Phase 1 Release

This release contains the complete lexical analyzer for Pitch++, 
a cricket-themed C++ programming language.

### Features
- 15 cricket-themed keywords
- 13 operators
- 7 punctuations
- Comprehensive error handling
- Cross-platform support

### Files
- scanner.l - Lexical analyzer
- test_program.pitch - Sample program
- Complete documentation

### Demo
Watch the demo video: [Link]

### Installation
See INSTALLATION.md for setup instructions.
```
5. Publish release

---

### 13. Common Git Commands Reference

```bash
# Check status
git status

# Add specific file
git add filename.txt

# Add all files
git add .

# Commit changes
git commit -m "your message"

# Push to GitHub
git push

# Pull latest changes
git pull

# View commit history
git log --oneline

# Create branch
git branch branch-name
git checkout branch-name

# View remote URL
git remote -v

# Change remote URL
git remote set-url origin https://github.com/NEW_USERNAME/pitch-plus-compiler.git
```

---

### 14. Troubleshooting

**Problem: "fatal: remote origin already exists"**
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/pitch-plus-compiler.git
```

**Problem: "Updates were rejected"**
```bash
git pull origin main --rebase
git push origin main
```

**Problem: "Authentication failed"**
- Use Personal Access Token instead of password
- Or use SSH keys
- Or use GitHub CLI (gh)

**Problem: Files not showing on GitHub**
```bash
git status  # Check if files are tracked
git add .   # Add all files
git commit -m "Add missing files"
git push
```

---

### 15. Submission Checklist

Before submitting GitHub link:

- [ ] Repository is PUBLIC
- [ ] All files are pushed
- [ ] README.md is clear and informative
- [ ] tokens.txt is included (generated output)
- [ ] errors.log is included
- [ ] Demo video is accessible (uploaded or linked)
- [ ] Repository description is set
- [ ] No sensitive information (passwords, emails)
- [ ] .gitignore is working (no lex.yy.c, scanner.exe tracked)
- [ ] GitHub link is correct and accessible

---

### 16. Get Your Repository Link

Your repository link will be:
```
https://github.com/YOUR_USERNAME/pitch-plus-compiler
```

**This is the link you'll submit for your assignment!**

Copy it and:
1. Test it in incognito/private browser (to verify it's public)
2. Make sure all files are visible
3. Submit to your assignment portal

---

### 17. After Submission

Keep the repository:
- It's part of your portfolio
- Shows your skills to potential employers
- Useful reference for future phases
- Can be improved and updated

Consider adding:
- Star your own repo (optional)
- Share with classmates (after deadline)
- Tweet about it
- Add to your resume/LinkedIn

---

## Quick Copy-Paste Commands

```bash
# Complete setup in one go
cd C:\Users\hp\Desktop\pitch-plus-compiler
git init
git add .
git commit -m "feat: Initial commit - Pitch++ Compiler Phase 1

Lexical analyzer for cricket-themed C++ language.
Author: Abdullah Butt (L1F22BSCS0497)"

# Replace YOUR_USERNAME with actual username
git remote add origin https://github.com/YOUR_USERNAME/pitch-plus-compiler.git
git branch -M main
git push -u origin main
```

---

## Need Help?

- Git documentation: https://git-scm.com/doc
- GitHub guides: https://guides.github.com/
- Git cheat sheet: https://education.github.com/git-cheat-sheet-education.pdf

---

**Good luck with your submission!** 🚀🏏

---

**Remember**: 
- Make repository PUBLIC
- Test the link in incognito mode
- Ensure all files are visible
- Submit the correct GitHub link

**Your GitHub link format**:
```
https://github.com/YOUR_USERNAME/pitch-plus-compiler
```

