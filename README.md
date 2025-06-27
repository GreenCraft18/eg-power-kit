# 🔊 eg-power-kit
**Bring the bass back to the terminal.**
EG Power Kit is a PowerShell module that turns your shell into a throwback audio experience. Whether you're launching MLG throwbacks, writing meme-ready intro functions, or just want your scripts to sound as cool as they look—this module delivers.

## 🎮 Features
- 🎵 EGShellSoundEngine — Play .mp3 files directly from PowerShell using .NET’s MediaPlayer
- Create-Environment-Variables — Create custom environment variables with `EG_` at the start.
- 📁 Find-Files — Find files in your directory by the name of whatever you want.
- Alias support like `help`, `ff`, and much more.
- 🧠 Compatibility fallback for both Program Files and Program Files (x86)
- 🗿 No COM dependencies. No WMP. No custom mods. Just pure shell juice.

## 🚀 Installation
Clone the repo into `C:\Program Files\WindowsPowerShell\Modules` or `C:\Program Files (x86)\WindowsPowerShell\Modules` for x86-based systems.
``` PowerShell
C:\Program Files\WindowsPowerShell\Modules> git clone https://github.com/GreenCraft18/eg-power-kit.git
C:\Program Files (x86)\WindowsPowerShell\Modules> git clone https://github.com/GreenCraft18/eg-power-kit.git
```
After that, import the module by using `Import-Module`.
``` PowerShell
C:\Users\$env:USERNAME> Import-Module "C:\Program Files\WindowsPowerShell\Modules\eg-power-kit"
C:\Users\$env:USERNAME> Import-Module "C:\Program Files (x86)\WindowsPowerShell\Modules\eg-power-kit"
```

> Note: Requires PowerShell 5+ and .NET (WPF support). If you don't have PowerShell 5 or above, do this.
> ``` PowerShell
> winget install --id Microsoft.PowerShell --source winget
> ```

## 📀 Usage
### Basic Playback with Options
``` PowerShell
Sound-Engine "C:\Music\Hope.mp3"
Sound-Engine "C:\Music\Hope.mp3" 0.8 15 -Loop
```

### Interactive Mode!
Just run commands bare and follow the prompts!
```
Sound-Engine
Find-Files
```

### Alias Examples!
Aliases!
``` PowerShell
Sound-Engine "C:\Music\Hope.mp3"
play-audio "C:\Sounds\airhorn.mp3" -Loop
MLG-TIME
ff
```

### `Get-Command` = False | `help` = True
If you don't know what that means, it really doesn't matter.  
In short terms, it means `Get-Command` doesn't exist, and instead is `help`.
``` PowerShell
help
----
Write-Msg / message`<message> - Displays a message.
Write-Host "Find-Files / ff <name> <path> <depth> - Finds files by name.
Write-Host "Recent-Files / recent <count> - Shows recently modified files within 30 days.
Write-Host "Reload-Module / reload - Reloads the module.
Write-Host "Module-Help / help - Displays this help message.
Write-Host "PC-User-Info / who-am-i - Displays the current user and computer name.
Write-Host "Clear-Screen / clear - Clears the screen.
Write-Host "Create-Environment-Variables / create-env <name>- Creates a custom environment variable.
Write-Host "View-Environment-Variables / view-env - Displays all custom environment variables.
Write-Host "MLG-TIME - Invokes a throwback to the MLG era with a fun message.
Write-Host Sound-Engine / playaudio <sound> <volume> <duration> <loop> - Plays an audio file with specified options.
```

## 🛠 Configuration
You can customize:
- Default paths or fallback logic
- Auto-load MLG themes
- Shell transition intros
- Sound presets based on time of day

## 🧠 Trivia
> This module was born from the ashes of WMPlayer.OCX errors and inspired by the eternal power of 2016 SFX memes.

## 📄 License
MIT License — see LICENSE for details.
