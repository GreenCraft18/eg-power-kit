Clear-Host # Clears the console screen when the module is loaded.
Write-Host "============================"   # Displays a header for the EG-power-kit module.
Write-Host "           EG-power-kit™"                # Displays the EG-power-kit logo.
Write-Host "                 v1.0.2"                           # Displays a message indicating the version.
Write-Host "============================"   # Displays a footer for the EG-power-kit module.

function global:Send-Msg { # Makes the `Send-Msg` function available globally.
    param ( # Defines the parameters for the `Send-Msg` function.
        [Parameter(Position = 0)] # Sets the position of the `$message` parameter.
        [string]$message  # The parameter/message to display.
    ) # End of parameters.
 
    if (-not $message) { # Checks if the message parameter is not provided.
        Write-Host "Usage: Send-Msg / message / msg `<message>` " # Displays usage instructions.
        Write-Host "Example: message ""Hello, World!""" # Provides an example of how to use the function.
        Write-Host "This function displays a message in the console." # Explains what the function does.
        return # Exits the function if no message is provided.
    } # End of if statement.
    
    Write-Host $message # Displays the provided message in the console.
} # End of the `Send-Msg` function.

function global:Find-Files { # Makes the `Find-Files` function available globally.
    param ( # Defines the parameters for the `Find-Files` function.
        [Parameter(Position = 0, Mandatory = $true)] # Makes the `$Name` parameter mandatory and sets its position.
        [string]$Name, # The name of the file to search for.

        [Parameter(Position = 1)] # Sets the position of the `$Path` parameter.
        [string]$Path = $(Read-Host "Path to search in (default: current folder)" ; if (-not $_) { "." } else { $_ }), # Ask the user the path to search in, defaulting to the current folder if not provided.

        [Parameter(Position = 2)] # Sets the position of the `$Depth` parameter.
        [int]$Depth = $(Read-Host "Depth to search (default: 3)" ; if (-not $_) { 3 } else { $_ }) # Asks the user for the depth of the search, defaulting to 3 if not provided.
    ) # End of parameters.

    Get-ChildItem -Path $Path -Recurse -Depth $Depth -File -ErrorAction SilentlyContinue | # Retrieves child items from the specified path, recursively searching up to the specified depth, and ignoring errors.
        Where-Object { $_.Name -like "*$Name*" } | # Filters the items to include only those whose names match the specified pattern.
        Format-Table Name, Directory, LastWriteTime -AutoSize # Formats the output as a table with specified columns.
} # End of the `Find-Files` function.

function global:EGShellFindMostRecentFiles { # Makes the `EGShellFindMostRecentFiles` function available globally.
    param ( # Defines the parameters for the `EGShellFindMostRecentFiles` function.
        [Parameter(Position = 0)] # Sets the position of the `$Count` parameter.
        [int]$Count = $(Read-Host "How many recent files would you like to see?") # Asks the user how many recent files they would like to see, defaulting to the value provided by the user.
    ) # End of parameters.
    Get-ChildItem -Path "C:\Users\Eugene & Jihoon" -Recurse -File -Force -ErrorAction Ignore | # Retrieves child items from the specified path, ignoring errors.
    Where-Object { $_.FullName -notmatch "C:\\Users\\Eugene & Jihoon\\AppData" } | # Ignores files in the AppData directory.
    Where-Object { $_.FullName -notmatch "NTUSER.DAT" } | # Excludes NTUSER.DAT files.
    Where-Object { $_.FullName -notmatch "NTUSER.DAT.LOG" } | # Excludes NTUSER.DAT.LOG files.
    Where-Object { $_.FullName -notmatch "NTUSER.DAT.LOG2" } | # Excludes NTUSER.DAT.LOG2 files.
    Where-Object { $_.FullName -notmatch "NTUSER.DAT.LOG1" } | # Excludes NTUSER.DAT.LOG1 files.
    Where-Object { $_.FullName -notmatch "NTUSER.INDEX" } | # Excludes NTUSER.INDEX files.
    Where-Object { $_.FullName -notmatch "NTUSER.INDEX.LOG" } | # Excludes NTUSER.INDEX.LOG files.
    Where-Object { $_.FullName -notmatch "NTUSER.INDEX.LOG1" } | # Excludes NTUSER.INDEX.LOG1 files.
    Where-Object { $_.FullName -notmatch "NTUSER.INDEX.LOG2" } | # Excludes NTUSER.INDEX.LOG2 files.
    Where-Object { $_.FullName -notmatch "C:\\Users\\Eugene & Jihoon\\.vscode" } | # Excludes the Visual Studio Code Extensions directory.
    Sort-Object LastWriteTime -Descending | # Sort the files by last write time in descending order.
    Select-Object -First $Count # Select the first `$Count` number of files.
} # End of the `EGShellFindMostRecentFiles` function.

function global:EGShellReloadModule { # Makes the `EGShellReloadModule` function available globally.
    $modulePath = "C:\Users\$env:USERNAME\PowerShell\Modules\eg-power-kit" # Sets `$modulePath` to the path of the module.
    Import-Module $modulePath # Reloads the module.
    Clear-Host # Clears the console. Used for removing "eg-power-kit module loaded successfully!" message.
    Write-Host "eg-power-kit module reloaded successfully!" # Displays a message indicating the module has been reloaded. 
} # End of the `EGShellReloadModule` function.

function global:EGShellPCUserInfo { # Makes the `EGShellPCUserInfo` function available globally.
    Write-Host "Current User Information:" # Displays a header for the user information.
    Write-Host "User: $env:USERNAME" # Displays the current username.
    Write-Host "Domain: $env:USERDOMAIN" # Displays the current user domain.
    Write-Host "Full Name: $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)" # Displays the full name of the current user.
    Write-Host "User SID: $([System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value)" # Displays the Security Identifier (SID) of the current user.
    Write-Host "User Profile Path: $env:USERPROFILE" # Displays the path to the current user's profile.
    Write-Host "Computer: $env:COMPUTERNAME" # Displays the current computer name.
} # End of the `EGShellPCUserInfo` function.

function global:EGShellMakeCustomEnvironmentVariables { # Makes the `EGShellMakeCustomEnvironmentVariables` function available globally.
    param ( # Defines the parameters for the `EGShellMakeCustomEnvironmentVariables` function.
        [Parameter(Mandatory = $true)] # Makes the `$EnvironmentVariableName` parameter mandatory.
        [string]$EnvironmentVariableName # The name of the environment variable to create.
    ) # End of parameters.

    if (-not $EnvironmentVariableName) { # Checks if the `$EnvironmentVariableName` parameter is not provided.
        $EnvironmentVariableName = Read-Host "Enter the name for the environment variable." # Asks the user to enter the name for the environment variable.
    } # End of if statement.

    if ($EnvironmentVariableName -match '\W') { # Checks if the name contains any non-word characters (anything other than letters, digits, or underscores).
        Write-Host "Environment variable names must only contain letters, digits, and underscores." # Displays an error message if the name is invalid.
        return # Exits the function if the name is invalid.
    }

    $EnvironmentVariableValue = Read-Host "Enter the value for the environment variable '$EnvironmentVariableName'" # Asks the user to enter the value for the environment variable.
    Set-Item -Path "Env:EG_$EnvironmentVariableName" -Value $EnvironmentVariableValue -ErrorAction SilentlyContinue # Sets the environment variable with the prefix "EG_". The `-ErrorAction SilentlyContinue` suppresses any errors if the variable already exists.
    Write-Host "Environment variable 'EG_$EnvironmentVariableName' set." # Displays a message indicating that the environment variable has been set.
    Write-Host "You can view it using the 'view-env' command." # Informs the user that they can view the variable using the `view-env` command.
} # End of the `EGShellMakeCustomEnvironmentVariables` function.

function global:EGShellViewCustomEnvironmentVariables { # Makes the `EGShellViewCustomEnvironmentVariables` function available globally.
    Get-ChildItem Env: | Where-Object { $_.Name -like "EG_*" } | # Retrieves all environment variables that start with "EG_".
    Format-Table Name, Value -AutoSize # Formats the output as a table with the names and values of the environment variables.
} # End of the `EGShellViewCustomEnvironmentVariables` function.

function global:Clear-Screen { # Makes the `Clear-Screen` function available globally.
    Clear-Host # Clears the console screen.
} # End of the `Clear-Screen` function.

function global:EGShell2016MLGThrowback { # Makes the `EGShell2016MLGThrowback` function available globally.
    Clear-Host # Clears the console screen.
    Write-Host "============================" # Displays a header for the MLG throwback.
    Write-Host "       Windows XP™"                    # Displays the Windows XP logo.
    Write-Host "       Phase Shift Mode"              # Displays a message indicating the phase shift mode.
    Write-Host "============================" # Displays a footer for the MLG throwback.
    Start-Sleep -Milliseconds 400 # Waits for 400 milliseconds before proceeding.
    Write-Host "Loading 'MyHopeWillNeverDie.mp3'..." # Displays a message indicating that the audio file is being loaded.
    Start-Sleep -Milliseconds 300
    Write-Host "*Airhorn.wav activated*" # Displays a message indicating that the airhorn sound has been activated.
    Start-Sleep -Milliseconds 250
    Write-Host ">>> QUICKSC0PE.EXE online <<<" # Displays a message indicating that the quickscope executable is online.
    Start-Sleep -Milliseconds 250
    Write-Host "Launching GeometryDash_MLG.gd..." # Displays a message indicating that the Geometry Dash MLG level is being launched.
    Start-Sleep -Milliseconds 500
    Write-Host "360 NOSCOPE SUCCESSFUL – HEADSHOT +9001" # Displays a message indicating that a 360 noscope was successful, with a score of +9001.

    # Use WPF-based MediaPlayer to play MP3 without relying on Windows Media Player.
    Add-Type -AssemblyName PresentationCore

    $soundPath = "C:\Program Files\PowerShell\7\Modules\eg-power-kit\MyHopeWillNeverDie.mp3" # Path to the audio file.

    if (-not (Test-Path $soundPath)) { # Checks if the audio file exists.
        $soundPath = "C:\Program Files (x86)\PowerShell\7\Modules\eg-power-kit\MyHopeWillNeverDie.mp3" # If not found, checks in the x86 directory.
        if (-not (Test-Path $soundPath)) { # Checks if the audio file exists.
            Write-Host "Audio file not found at: $soundPath" -ForegroundColor Red # Displays an error message if the file is not found.
            return # Exits the function if the file is not found.
        }
    } # End of the if block checking for audio file existence.

    $player = New-Object System.Windows.Media.MediaPlayer # Creates a new MediaPlayer object to play the audio file.
    $player.Open([Uri]::new($soundPath)) # Opens the audio file using the MediaPlayer.
    $player.Play() # Starts playing the audio file.

    Start-Sleep -Seconds 5 # Wait for the sound to play for 5 seconds.

    Write-Host "My hope will never die..." # Displays a message indicating that the hope will never die.
} # End of the `EGShell2016MLGThrowback` function.

function global:EGShellSoundEngine {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$Path,

        [Parameter(Position = 1)]
        [ValidateRange(0.0, 1.0)]
        [double]$Volume = 1.0,

        [Parameter(Position = 2)]
        [int]$DurationSeconds = 10,

        [Parameter(Position = 3)]
        [switch]$Loop
    )

    Add-Type -AssemblyName PresentationCore

    if (-not $Path) {
        $Path = Read-Host "Enter the path where the sound you want to play"
    }

    if (-not (Test-Path $Path)) {
        Write-Host "Audio file not found: $Path" -ForegroundColor Red
        return
    }

    if ($null -eq $PSBoundParameters['Volume']) {
        $volInput = Read-Host "Enter volume (0.0 to 1.0, default is 1.0)"
        if ($volInput) { $Volume = [double]$volInput }
    }

    if ($null -eq $PSBoundParameters['DurationSeconds'] -and -not $Loop) {
        $durInput = Read-Host "Enter playback duration in seconds (default: 10)"
        if ($durInput) { $DurationSeconds = [int]$durInput }
    }

    if (-not $PSBoundParameters['Loop']) {
        $loopInput = Read-Host "Do you want it to loop (Y/N)?"
        if ($loopInput -match '^[Yy]') {
            $Loop = $true
        }
    }

    $player = New-Object System.Windows.Media.MediaPlayer
    $player.Open([Uri]::new($Path))
    $player.Volume = $Volume

    if ($Loop) {
        Write-Host "Looping enabled – press Enter to stop playback..."
        Register-ObjectEvent -InputObject $player -EventName MediaEnded -Action {
            $player.Position = [TimeSpan]::Zero
            $player.Play()
        } | Out-Null

        $player.Play()
        Read-Host "" | Out-Null
        $player.Stop()
    }
    else {
        $player.Play()
        Start-Sleep -Seconds $DurationSeconds
        $player.Stop()
    }

    Write-Host "Playback complete."
}

Set-Alias PC-User-Info EGShellPCUserInfo
Set-Alias who-am-i EGShellPCUserInfo
Set-Alias view-env EGShellViewCustomEnvironmentVariables
Set-Alias View-Environment-Variables EGShellViewCustomEnvironmentVariables
Set-Alias Create-Environment-Variables EGShellMakeCustomEnvironmentVariables
Set-Alias create-env EGShellMakeCustomEnvironmentVariables
Set-Alias ff Find-Files
Set-Alias message Send-Msg
Set-Alias Recent-Files EGShellFindMostRecentFiles
Set-Alias recent EGShellFindMostRecentFiles
Set-Alias Reload-Module EGShellReloadModule
Set-Alias reload EGShellReloadModule
Set-Alias Module-Help EGShellGetModuleHelp
Set-Alias help EGShellGetModuleHelp
Set-Alias clear Clear-Screen
Set-Alias MLG-TIME EGShell2016MLGThrowback
Set-Alias Sound-Engine EGShellSoundEngine
Set-Alias playaudio EGShellSoundEngine
Set-Alias msg Send-Msg

function global:EGShellGetModuleHelp {
    Write-Host "Send-Msg / message / msg `<message>` - Displays a message."
    Write-Host "Find-Files / ff `<name> <path> <depth>` - Finds files by name."
    Write-Host "Recent-Files / recent `<count>` - Shows recently modified files within 30 days."
    Write-Host "Reload-Module / reload - Reloads the module."
    Write-Host "Module-Help / help - Displays this help message."
    Write-Host "PC-User-Info / who-am-i - Displays the current user and computer name."
    Write-Host "Clear-Screen / clear - Clears the screen."
    Write-Host "Create-Environment-Variables / create-env `<name>`- Creates a custom environment variable."
    Write-Host "View-Environment-Variables / view-env - Displays all custom environment variables."
    Write-Host "MLG-TIME - Invokes a throwback to the MLG era with a fun message."
    Write-Host "Sound-Engine / playaudio `<sound> <volume> <duration> <loop>` - Plays an audio file with specified options."
}
