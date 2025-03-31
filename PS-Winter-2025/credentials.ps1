# Securely Handle Credentials
$cred = Get-Credential
$cred | Export-Clixml -Path "cred.xml"

#Import Credentials Securely
$cred2 = Import-Clixml -Path "cred.xml"
Write-Host "credentials: $cred2"
