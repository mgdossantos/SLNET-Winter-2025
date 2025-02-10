$i=1
while ($i -gt 5) {
    Get-Process | Where-Object { $_.CPU -gt 50 }
    Start-Sleep -Seconds 5
    $i++
}