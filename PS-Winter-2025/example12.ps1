$processes = Get-Process | Select-Object Name, Id, CPU
$processes | ConvertTo-Json -Depth 2| Out-File "C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\SLNET-Winter-2025\PS-Winter-2025\processes2.json"
# Confirm success
Write-Output "Process data saved to processes.json"