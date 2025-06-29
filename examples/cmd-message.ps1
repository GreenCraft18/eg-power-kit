Write-Host "Importing Module..."
Write-Host "Command: [Import-Module ""C:\Program Files\WindowsPowerShell\Modules\eg-power-kit""]"
Write-Host "For (x86) systems, use: [Import-Module ""C:\Program Files (x86)\WindowsPowerShell\Modules\eg-power-kit""]"
Start-Sleep -Seconds 5
Import-Module "C:\Program Files\WindowsPowerShell\Modules\eg-power-kit"
Start-Sleep -Seconds 3
Write-Host "Send-Msg / message / msg `<message>` - Displays a message. | ""Ohhh, that's cool!"""
Start-Sleep -Seconds 3.5
message "(types in [message])"
Start-Sleep -Seconds 3.5
message "Usage: Send-Msg / message / msg `<message>` "
Start-Sleep -Seconds 3.5
message """Alright."""
Start-Sleep -Seconds 3.5
message "(types in [message ""Hello, World!""])"
Start-Sleep -Seconds 3.5
message "Hello, World!"
Start-Sleep -Seconds 3.5