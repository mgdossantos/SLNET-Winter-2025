# Define JSON log file paths
$networkLog = "C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\SLNET-Winter-2025\PS-Winter-2025\established_connections.json"

# Continuous monitoring loop
while ($true) {
    Write-Output "Monitoring network connections..."
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" } | 
        Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
    
    $logEntry = @{
        Timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        Event     = "Network"
    }
    $jsonEntry = $logEntry | ConvertTo-Json -Depth 2


    if($connections) {
        
        # Append JSON with a separator (avoids corruption)
        $jsonEntry + "," | Add-Content -Path $networkLog 
        $connections= $connections | ConvertTo-Json -Depth 2 
        $connections + "," | Add-Content -Path $networkLog 

    }
    Start-Sleep -Seconds 30  # Wait 30 seconds before next iteration
}

