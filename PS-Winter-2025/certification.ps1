# 2. Create a Self-Signed Certificate for Script Signing
#New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -Subject "CN=PowerShell Code Signing"

# 3. Sign a Script (replace with your actual script path and certificate)
#$cert = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.Subject -eq "CN=PowerShell Code Signing" } | Select-Object -First 1
$cert = New-SelfSignedCertificate `
  -CertStoreLocation "Cert:\\CurrentUser\\My" `
  -Subject "CN=PowerShell Code Signing" `
  -Type CodeSigningCert `
  -KeyExportPolicy Exportable `
  -KeySpec Signature `
  -NotAfter (Get-Date).AddYears(1)

$cert = Get-ChildItem -Path Cert:\CurrentUser\My |
    Where-Object { $_.Subject -eq "CN=PowerShell Code Signing" -and $_.EnhancedKeyUsageList.FriendlyName -contains "Code Signing" } |
    Select-Object -First 1

Set-AuthenticodeSignature -FilePath C:\Users\tchel\Documents\GitHub\SLNET--WINTER-2025\SLNET-Winter-2025\PS-Winter-2025\example1.ps1 -Certificate $cert
