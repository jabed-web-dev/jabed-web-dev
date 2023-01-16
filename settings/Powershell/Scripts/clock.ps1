# ┏ ┓ ┗ ┛ ┣ ┫ ━ ┃ ╹ • 

$clockNumbers = @(
    @(
        '┏━━━━━┓',
        '┃     ┃',
        '┃     ┃',
        '┃     ┃',
        '┃     ┃',
        '┃     ┃',
        '┗━━━━━┛'
    ),
    @(
        '      ┓',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ╹'
    ),
    @(
        '┏━━━━━┓',
        '      ┃',
        '      ┃',
        '┏━━━━━┛',
        '┃      ',
        '┃      ',
        '┗━━━━━┛'
    ),
    @(
        '┏━━━━━┓',
        '      ┃',
        '      ┃',
        ' ━━━━━┫',
        '      ┃',
        '      ┃',
        '┗━━━━━┛'
    ),
    @(
        '┏     ┓',
        '┃     ┃',
        '┃     ┃',
        '┗━━━━━┫',
        '      ┃',
        '      ┃',
        '      ┛'
    ),
    @(
        '┏━━━━━┓',
        '┃      ',
        '┃      ',
        '┗━━━━━┓',
        '      ┃',
        '      ┃',
        '┗━━━━━┛'
    ),
    @(
        '┏━━━━━┓',
        '┃      ',
        '┃      ',
        '┣━━━━━┓',
        '┃     ┃',
        '┃     ┃',
        '┗━━━━━┛'
    ),
    @(
        '┏━━━━━┓',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ┃',
        '      ┛'
    ),
    @(
        '┏━━━━━┓',
        '┃     ┃',
        '┃     ┃',
        '┣━━━━━┫',
        '┃     ┃',
        '┃     ┃',
        '┗━━━━━┛'
    ),
    @(
        '┏━━━━━┓',
        '┃     ┃',
        '┃     ┃',
        '┗━━━━━┫',
        '      ┃',
        '      ┃',
        '┗━━━━━┛'
    )
)

function StartTime {
    param ([string]$color = "DarkRed")
    try {
        $hh = Get-Date -Format 'hh'
        $mm = Get-Date -Format 'mm'
        $ss = Get-Date -Format 'ss'
        $tt = Get-Date -Format 'tt'
    
        $hh0 = [Convert]::ToInt32($hh[0], 10)
        $hh1 = [Convert]::ToInt32($hh[1], 10)
        $mm0 = [Convert]::ToInt32($mm[0], 10)
        $mm1 = [Convert]::ToInt32($mm[1], 10)
        $ss0 = [Convert]::ToInt32($ss[0], 10)
        $ss1 = [Convert]::ToInt32($ss[1], 10)

        Clear-Host 
        Write-Output ""
        
        for ($i = 0; $i -lt $clockNumbers[0].Length; $i++) {
            $dot = ($i -eq 1) -or ($i -eq $clockNumbers[0].Length - 2) ? '•' : ' '
            $logStr = " " + $clockNumbers[$hh0][$i] + " " + $clockNumbers[$hh1][$i] + "  $dot  " + $clockNumbers[$mm0][$i] + " " + $clockNumbers[$mm1][$i] + "  $dot  " + $clockNumbers[$ss0][$i] + " " + $clockNumbers[$ss1][$i] + " " + ($i -eq $clockNumbers[0].Length - 2 ? $tt : '')
            Write-Host $logStr -ForegroundColor $color
        }
    }
    catch {
        Write-Error -Message "Invalid Argument"
    }
}

while ($true) {
    StartTime 
    Start-Sleep -Seconds 1
}
