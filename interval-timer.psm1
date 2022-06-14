Add-Type -AssemblyName presentationCore
function playAudio {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$AudioPath
    )
    $mediaPlayer = New-Object system.windows.media.mediaplayer  
    
    $mediaPlayer.open((join-path $PSScriptRoot $AudioPath))
    $mediaPlayer.Play()        
}

function runTimer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [double[]]$Intervals
    )

    $stopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
    $len = $Intervals.Count
    $i = 0
    do {       
        $timer = [System.TimeSpan]::FromMinutes($Intervals[$i])
        $stopWatch.Start()
        while (1) {
            $remaining = $timer - $stopWatch.Elapsed    
            if ($remaining.TotalSeconds -le 0) {           
                break
            }
            $s = "{0:d2}h:{1:d2}m:{2:d2}s" -f $remaining.hours, $remaining.minutes, $remaining.seconds
            $host.ui.RawUI.WindowTitle = $s
            write-host -NoNewline "`r$s" 
            Start-Sleep -s 1   
        }
        $i++
        $a = "interval.mp3"
        if ($i -eq $len) {
            $a = "set.mp3"
        }
        playAudio -AudioPath $a
        $stopWatch.Reset()
    }while ($i -lt $len) 
}

<#
.SYNOPSIS
    timer -- a pomodoro/interval timer based on https://github.com/rlue/timer/ for windows powershell
.DESCRIPTION
    timer is implemented as a function, run this script in your pofile.ps1 file to have it available always.
    Make sure the bell mp3 files are available in same path as script.  

    - Interval values are in minutes, can be entered as decimal. e.g. 0.5 for 30 sec
    - Delay values are in seconds
    - Repeat value is an integer, for a negative number the timer repeats intervals indefinitely

.NOTES
   This function is not supported only in windows

.EXAMPLE
        
        timer -Intervals 25,5,30,4 -Delay 6 -Repeat 2       

    This will create a timer which will bell at specied intervals of 25 min, 5 min, 30 min and 4 min.
    The timer will start after a delay of 6 seconds, and whole intervals will be reapeated 2 times.
.Example
        timer 25,5,30,4 -d 6 -r 2
    
    Same as above
#>
function timer {
    [CmdletBinding(DefaultParameterSetName = "Run")]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [double[]]$Intervals,
        # Repeat timer
        
        [Parameter()]
        [Alias('r')]
        [int]$Repeat = 1,
        # Delay timer start by seconds
        [Parameter()]
        [Alias('d')]
        [int]$Delay = 0        
    )
    
    process {
        $title = $host.UI.RawUI.WindowTitle
        $hasFinished = $false
        try {
            Start-Sleep $Delay            
            $i = $Repeat
            while ($i -ne 0) {
                runTimer -Intervals $Intervals
                $i--
            }     
            $hasFinished = $true
            write-host "`r$((Get-Date).ToString("[HH:mm]")) Timer Elapsed" 
        }
        finally {
            $host.UI.RawUI.WindowTitle = $title    
            if (-not $hasFinished) {
                write-host "`rTimer cancelled"
            }
        }
    }
    
}
