# System Information Collection Script

# Get Computer Name
$computerName = $env:COMPUTERNAME

# Get OS Version
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$osVersion = $os.Caption + " " + $os.Version

# Get CPU Info
$cpu = Get-CimInstance -ClassName Win32_Processor
$cpuInfo = $cpu.Name

# Get RAM Size (in GB)
$ramSize = [Math]::Round(($os.TotalVisibleMemorySize / 1MB), 2)

# Get Disk Sizes
$disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
$diskInfo = $disks | Select-Object DeviceID, @{Name="Size(GB)";Expression={[Math]::Round($_.Size / 1GB, 2)}}

# Get MAC Addresses
$macAddresses = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -ExpandProperty MacAddress

# Output Information
Write-Host "Computer Name: $computerName"
Write-Host "OS Version: $osVersion"
Write-Host "CPU: $cpuInfo"
Write-Host "RAM Size (GB): $ramSize"
Write-Host "`nDisk Information:"
$diskInfo | Format-Table -AutoSize
Write-Host "`nMAC Addresses:"
$macAddresses

# Optional: Export to a file for inventory
$inventory = [PSCustomObject]@{
    ComputerName = $computerName
    OSVersion    = $osVersion
    CPU          = $cpuInfo
    RAM_GB       = $ramSize
    MACAddresses = ($macAddresses -join ", ")
}

$inventory | Export-Csv -Path ".\System_Inventory.csv" -NoTypeInformation
