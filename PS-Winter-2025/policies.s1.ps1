# Check and Set Execution Policy


$executionPolicy= Get-ExecutionPolicy
Write-Host "Actual Execution Policy: $executionPolicy"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


$executionPolicy= Get-ExecutionPolicy
Write-Host "After Set a new one Execution Policy: $executionPolicy"






