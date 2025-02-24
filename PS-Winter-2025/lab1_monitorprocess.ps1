# Define JSON log file paths
$processLog = "C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\SLNET-Winter-2025\PS-Winter-2025\high_cpu_processes.json"

# Continuous monitoring loop
while ($true) {
    Write-Output "Monitoring system processes and network connections..."
   
    $processes = Get-Process | Where-Object { $_.CPU -gt 10 } | Select-Object ProcessName, ID, CPU
    
    $logEntry = @{
        Timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        Event     = "CPU Usage High"
    }
    $jsonEntry = $logEntry | ConvertTo-Json -Depth 2


    if($processes) {
        
        # Append JSON with a separator (avoids corruption)
        $jsonEntry + "," | Add-Content -Path $processLog
        $processes= $processes | ConvertTo-Json -Depth 2 
        $processes + "," | Add-Content -Path $processLog

    }
    Start-Sleep -Seconds 30  # Wait 30 seconds before next iteration
}