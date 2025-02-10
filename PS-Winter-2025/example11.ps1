$servers = @("google.com", "microsoft.com", "yahoo.com")
$logFile = "C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\PS-Winter-2025\ping_results.txt"

foreach ($server in $servers) {
    $status = Test-NetConnection -ComputerName $server
    if ($status.PingSucceeded) {
        Add-Content -Path $logFile -Value "$(Get-Date) - $server is reachable"
    } else {
        Add-Content -Path $logFile -Value "$(Get-Date) - $server is unreachable"
    }
}
Write-Output "Ping test completed. Results saved in $logFile"