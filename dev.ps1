# PowerShell development script
Write-Host "Starting development environment..." -ForegroundColor Green

# Check if Azurite is running
$azuriteProcess = Get-Process -Name "azurite" -ErrorAction SilentlyContinue

if (-not $azuriteProcess) {
    Write-Host "Starting Azurite..." -ForegroundColor Yellow
    Start-Process -FilePath "azurite" -ArgumentList "--silent", "--location", "./azurite" -WindowStyle Hidden
    Start-Sleep -Seconds 3
}
else {
    Write-Host "Azurite is already running" -ForegroundColor Cyan
}

# Start development servers
Write-Host "Starting development servers..." -ForegroundColor Green
npm run dev
