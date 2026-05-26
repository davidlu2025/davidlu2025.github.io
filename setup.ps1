# =============================================================
#  Blog Setup Script - Run once in the blog directory
#  Usage: .\setup.ps1
# =============================================================

$GITHUB_USERNAME = "davidlu2025"
$REPO_NAME       = "$GITHUB_USERNAME.github.io"
$THEME_URL       = "https://github.com/adityatelange/hugo-PaperMod"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  David Lu Blog - Setup Wizard" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# -- Step 1: Check Hugo ----------------------------------------
Write-Host "[1/5] Checking Hugo installation..." -ForegroundColor Yellow
if (-not (Get-Command hugo -ErrorAction SilentlyContinue)) {
    Write-Host "  Hugo not found. Installing via winget..." -ForegroundColor Red
    winget install Hugo.Hugo.Extended
    Write-Host ""
    Write-Host "  Hugo installed. Please RESTART this terminal and run the script again." -ForegroundColor Green
    exit 0
} else {
    $v = hugo version
    Write-Host "  OK: $v" -ForegroundColor Green
}

# -- Step 2: Init Git ------------------------------------------
Write-Host ""
Write-Host "[2/5] Initializing Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init
    git checkout -b main
    Write-Host "  OK: Git repo initialized on branch main" -ForegroundColor Green
} else {
    Write-Host "  OK: Git repo already exists" -ForegroundColor Green
}

# -- Step 3: Add PaperMod theme --------------------------------
Write-Host ""
Write-Host "[3/5] Adding PaperMod theme as git submodule..." -ForegroundColor Yellow
if (-not (Test-Path "themes/PaperMod")) {
    git submodule add --depth=1 $THEME_URL themes/PaperMod
    git submodule update --init --recursive
    Write-Host "  OK: Theme added" -ForegroundColor Green
} else {
    Write-Host "  OK: Theme already exists" -ForegroundColor Green
}

# -- Step 4: Test build ----------------------------------------
Write-Host ""
Write-Host "[4/5] Testing Hugo build..." -ForegroundColor Yellow
hugo --gc 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  OK: Build succeeded" -ForegroundColor Green
    Remove-Item -Recurse -Force public -ErrorAction SilentlyContinue
} else {
    Write-Host "  ERROR: Build failed. Running hugo again to show errors:" -ForegroundColor Red
    hugo --gc
    exit 1
}

# -- Step 5: Initial commit ------------------------------------
Write-Host ""
Write-Host "[5/5] Creating initial commit..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit: Hugo + PaperMod blog"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host ""
Write-Host "  1. Create a GitHub repo named: $REPO_NAME" -ForegroundColor Yellow
Write-Host "     https://github.com/new  (do NOT init with README)" -ForegroundColor Gray
Write-Host ""
Write-Host "  2. Push your code:" -ForegroundColor Yellow
Write-Host "     git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git" -ForegroundColor Gray
Write-Host "     git push -u origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "  3. Enable GitHub Pages:" -ForegroundColor Yellow
Write-Host "     Repo Settings -> Pages -> Source -> GitHub Actions" -ForegroundColor Gray
Write-Host ""
Write-Host "  4. Wait ~2 min, then visit:" -ForegroundColor Yellow
Write-Host "     https://$GITHUB_USERNAME.github.io" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Local preview: hugo server -D" -ForegroundColor Green
Write-Host ""
