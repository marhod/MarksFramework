# PowerShell start script
Write-Host "Starting services..." -ForegroundColor Green

# Start Azurite
$azuriteProcess = Get-Process -Name "azurite" -ErrorAction SilentlyContinue

if (-not $azuriteProcess) {
    Write-Host "Starting Azurite..." -ForegroundColor Yellow
    Start-Process -FilePath "azurite" -ArgumentList "--silent", "--location", "./azurite" -WindowStyle Hidden
    Write-Host "Azurite started" -ForegroundColor Green
}
else {
    Write-Host "Azurite is already running" -ForegroundColor Cyan
}
