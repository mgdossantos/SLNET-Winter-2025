Write-Host "🔧 Starting PowerShell Remoting setup for user 'TCHELLITALAPTOP\\tchel'..." -ForegroundColor Cyan

# Local user (fully qualified)
$username = "TCHELLITALAPTOP\tchel"

# 1. Enable PS Remoting
Write-Host "🔌 Enabling PowerShell Remoting..."
Enable-PSRemoting -Force

# 2. Add user to Remote Management Users group
Write-Host "➕ Adding user 'TCHELLITALAPTOP\\tchel' to 'Remote Management Users' group..."
try {
    Add-LocalGroupMember -Group "Remote Management Users" -Member $username -ErrorAction Stop
    Write-Host "✅ User added to group." -ForegroundColor Green
} catch {
    Write-Host "⚠️  Warning: User may already be in the group or there was an error: $($_.Exception.Message)" -ForegroundColor Yellow
}

# 3. Enable Basic Auth and unencrypted traffic (for localhost testing)
Write-Host "🔐 Enabling Basic authentication and unencrypted traffic..."
Set-Item WSMan:\localhost\Client\Auth\Basic $true
Set-Item WSMan:\localhost\Service\Auth\Basic $true
Set-Item WSMan:\localhost\Client\AllowUnencrypted $true
Set-Item WSMan:\localhost\Service\AllowUnencrypted $true

# 4. Grant endpoint permission
Write-Host "🔓 Granting endpoint permissions to 'TCHELLITALAPTOP\\tchel'..."
try {
    Add-Type -AssemblyName System.Management.Automation
    $identity = New-Object System.Security.Principal.NTAccount($username)
    $sd = Get-PSSessionConfiguration -Name Microsoft.PowerShell
    $acl = $sd.SecurityDescriptor
    $rule = New-Object System.Management.Automation.Remoting.PSSessionConfigurationAccessRule($identity, "FullControl", "Allow")
    $acl.AddAccessRule($rule)
    Set-PSSessionConfiguration -Name Microsoft.PowerShell -SecurityDescriptorSddl $acl.GetSddlForm("All") -Force
    Write-Host "✅ Endpoint permissions set." -ForegroundColor Green
} catch {
    Write-Host "⚠️  Could not automatically set endpoint permissions. Run the command below manually if needed:" -ForegroundColor Yellow
    Write-Host "Set-PSSessionConfiguration -Name Microsoft.PowerShell -ShowSecurityDescriptorUI" -ForegroundColor Yellow
}

# 5. Restart WinRM
Write-Host "🔁 Restarting WinRM service..."
Restart-Service WinRM

# 6. Prompt for password and test session
Write-Host "`n🔐 Testing remote session to localhost using 'TCHELLITALAPTOP\\tchel'..."
$password = Read-Host -AsSecureString "Enter the password for TCHELLITALAPTOP\\tchel"
$cred = New-Object System.Management.Automation.PSCredential($username, $password)

try {
    Enter-PSSession -ComputerName localhost -Credential $cred -Authentication Basic
} catch {
    Write-Host "❌ Remote session failed: $($_.Exception.Message)" -ForegroundColor Red
}