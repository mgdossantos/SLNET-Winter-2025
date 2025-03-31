# Securely Handle Credentials
$cred = Get-Credential
$cred | Export-Clixml -Path "cred.xml"

#Import Credentials Securely
$cred = Import-Clixml -Path "cred.xml"
