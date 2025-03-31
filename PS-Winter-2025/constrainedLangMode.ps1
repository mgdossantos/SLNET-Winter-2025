# PowerShell Constrained Language Mode - Demo Script

# Step 1: Display current language mode
Write-Host "Current Language Mode:"
$ExecutionContext.SessionState.LanguageMode

# Step 2: Simulate Constrained Language Mode (Temporary and for testing only)
Write-Host "`nSwitching to Constrained Language Mode for simulation..."
$ExecutionContext.SessionState.LanguageMode = 'ConstrainedLanguage'
Write-Host "Language Mode now set to:" $ExecutionContext.SessionState.LanguageMode

# Step 3: Try basic command (allowed)
Write-Host "`nRunning a basic allowed command:"
Get-Process | Select-Object -First 3

# Step 4: Try a restricted command - COM Object
Write-Host "`nAttempting to create a COM Object (should fail):"
try {
    $object = New-Object -ComObject "Scripting.FileSystemObject"
} catch {
    Write-Host "Error:" $_.Exception.Message
}

# Step 5: Try a restricted command - Add-Type
Write-Host "`nAttempting to use Add-Type (should fail):"
try {
    Add-Type -AssemblyName System.Windows.Forms
} catch {
    Write-Host "Error:" $_.Exception.Message
}

# Step 6: Reminder to reset session
Write-Host "`nTo return to FullLanguage mode, please restart PowerShell."

# End of script
