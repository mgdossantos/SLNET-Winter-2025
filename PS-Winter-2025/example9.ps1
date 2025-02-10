while ($true) {
    $highCPU = Get-Process | Where-Object { $_.CPU -gt 100 }
    if ($highCPU) {
        Write-Output "High CPU usage detected! Exiting..."
        break
    }
    Start-Sleep -Seconds 5
}