# PowerShell setup script
Write-Host "Setting up the project..." -ForegroundColor Green

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install

# Build shared package first
Write-Host "Building shared package..." -ForegroundColor Yellow
npm run build:shared

# Check for Azurite
$azuriteInstalled = Get-Command azurite -ErrorAction SilentlyContinue

if (-not $azuriteInstalled) {
    Write-Host "Azurite not found. Installing globally..." -ForegroundColor Yellow
    npm install -g azurite
}

Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "Run 'npm run dev' or './dev.ps1' to start development" -ForegroundColor Cyan
