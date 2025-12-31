# PowerShell stop script
Write-Host "Stopping services..." -ForegroundColor Yellow

# Stop Azurite
$azuriteProcess = Get-Process -Name "azurite" -ErrorAction SilentlyContinue

if ($azuriteProcess) {
    Stop-Process -Name "azurite" -Force
    Write-Host "Azurite stopped" -ForegroundColor Green
}
else {
    Write-Host "Azurite is not running" -ForegroundColor Cyan
}

# Stop any func processes
$funcProcess = Get-Process -Name "func" -ErrorAction SilentlyContinue

if ($funcProcess) {
    Stop-Process -Name "func" -Force
    Write-Host "Azure Functions stopped" -ForegroundColor Green
}

Write-Host "All services stopped" -ForegroundColor Green
