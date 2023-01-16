function mklink {
    param([string]$Target, [string]$Path)

    $SourcePath = (Get-Command -Name $Target -ErrorAction Ignore).Source
    $SourcePath = $SourcePath -eq $null ? '' : $SourcePath
    if ((Test-Path -Path $SourcePath) -eq $false) {
        if ((Test-Path -Path $Target) -eq $false) {
            return Write-Error "Invalid Target"
        } else {
            $Target = Convert-Path -Path $Target
        }
    } else {
        $Target = $SourcePath
    }

    $Path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    if ((Test-Path -Path $Path) -eq $true) {
        return "The $Path already exists"
    }

    if ((Test-Admin) -eq $true) {
        New-Item -ItemType SymbolicLink -Target $Target -Path $Path
    } else {
        Start-Process pwsh.exe "-NoLogo -NoProfile -Command `"New-Item -ItemType SymbolicLink -Target `'$Target`' -Path `'$Path`'`"" -Verb RunAs -Wait -WindowStyle Hidden
        Get-ItemProperty $Path
    }
}