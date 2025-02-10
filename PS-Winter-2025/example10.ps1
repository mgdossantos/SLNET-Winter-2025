$logFile = "C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\PS-Winter-2025\network_log.txt"

while ($true) {
    $status = Test-NetConnection -ComputerName google.com
    if ($status.PingSucceeded -eq $false) {
        Add-Content -Path $logFile -Value "$(Get-Date) - Connection lost"
    } else {
        Add-Content -Path $logFile -Value "$(Get-Date) - Connection active"
    }
    Start-Sleep -Seconds 10
}