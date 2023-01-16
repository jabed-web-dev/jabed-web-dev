if ($env:TERM_PROGRAM -eq "vscode") {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\oh-my-posh.omp.json" | Invoke-Expression
} else {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\oh-my-posh.omp.json" | Invoke-Expression
}

Import-Module posh-git
Import-Module Terminal-Icons

. $PSScriptRoot\Scripts\ReadLineSuggestion.ps1
. $PSScriptRoot\Scripts\ShowWindow.ps1
. $PSScriptRoot\Scripts\mklink.ps1
. $PSScriptRoot\Scripts\deno.ps1


# Set-Alias node node-v16.exe
Set-Alias rn Rename-Item
Set-Alias open start

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function pwsh {
    pwsh.exe -NoLogo $args
}

function edge {
	for ($i = 0; $i -lt $args.length; $i++) {
		if (Test-Path -Path $args[$i]) {
			$args[$i] = Convert-Path -Path $args[$i]
		}
	}
	if ($args) {
	    msedge.exe $args
	} else {
		Show-Window -Name msedge
    }
}

function google {
    if ($args) {
	    msedge.exe "https://www.google.com/search?q=$args"
    } else {
        msedge.exe "https://www.google.com"
    }
}

function translate {
    if ($args) {
	    msedge.exe "https://translate.google.com/?sl=en&tl=bn&text=$args&op=translate"
    } else {
        msedge.exe "https://translate.google.com"
    }
}

function youtube {
    if ($args) {
        $args = $args -join "+"
        msedge.exe "https://www.youtube.com/results?search_query=$args"
    } else {
        msedge.exe "https://www.youtube.com"
    }
}

function Terminal-RunAs {
    param([string]$Path = ".")
    if ((Test-Path -Path $Path) -eq $false) {
       return Write-Error "Invalid Path"
    }
    $Path = Convert-Path -Path $Path
    if ((Test-Admin) -eq $false) {
        Start-Process pwsh.exe "-NoLogo -NoProfile -Command `"wt.exe new-tab -p PowerShell -d '$Path'`"" -Verb RunAs -WindowStyle Hidden -Wait
    } else {
        wt.exe new-tab -p PowerShell -d $Path
    }
}

function Open-Host {
    $wtArgs = "wt.exe new-tab -p PowerShell pwsh.exe -NoLogo -NoProfile -Command `"vim 'C:\Windows\System32\drivers\etc\hosts'`""
    if ((Test-Admin) -eq $false) {
        Start-Process pwsh.exe "-NoLogo -NoProfile -Command $wtArgs" -Verb RunAs -WindowStyle Hidden -Wait
    } else {
        Invoke-Expression $wtArgs
    }
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
