# Start Transcript for Logging
Start-Transcript -Path "C:\output.txt" -Append

# Install OpenSSH
Write-Output "Installing OpenSSH..."
Get-WindowsCapability -Online -Name OpenSSH* | Add-WindowsCapability -Online
Write-Output "OpenSSH installed successfully."

# Configure OpenSSH service
Write-Output "Configuring OpenSSH service..."
Set-Service -Name sshd -StartupType Automatic
Start-Service sshd
Write-Output "OpenSSH service started and set to automatic."

# Disable Windows Firewall for all profiles
Write-Output "Disabling Windows Firewall for all profiles..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False -Confirm:$false
Write-Output "Windows Firewall disabled."

# Complete the script
Write-Output "Script execution completed."

# Stop Transcript
Stop-Transcript