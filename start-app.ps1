# PowerShell script to manage the Vue.js application

# Constants
$AppName = "mads-ui"
$LogFile = "app.log"
$PidFile = "app.pid"
$AppPort = 8081

# Functions
function Start-App {
    if (Test-Path $PidFile) {
        $processId = Get-Content $PidFile
        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue
        if ($process) {
            Write-Host "App is already running with PID: $processId"
            return
        }
        else {
            Write-Host "Stale PID file found. Removing it."
            Remove-Item $PidFile
        }
    }

    Write-Host "Starting $AppName..."
    $process = Start-Process -FilePath "npm" -ArgumentList "run serve" -NoNewWindow -PassThru -RedirectStandardOutput $LogFile -RedirectStandardError $LogFile
    $process.Id | Out-File $PidFile
    Write-Host "$AppName started with PID: $($process.Id)"
    Write-Host "Logs are being written to $LogFile"
    Write-Host "App URL: http://localhost:$AppPort"
}

function Stop-App {
    if (Test-Path $PidFile) {
        $processId = Get-Content $PidFile
        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue
        if ($process) {
            Write-Host "Stopping $AppName with PID: $processId..."
            Stop-Process -Id $processId -Force
            Remove-Item $PidFile
            Write-Host "$AppName stopped"
        }
        else {
            Write-Host "No running process found with PID: $processId"
            Remove-Item $PidFile
        }
    }
    else {
        Write-Host "No PID file found. App is not running or was not started with this script."
    }
}

function Get-AppStatus {
    if (Test-Path $PidFile) {
        $processId = Get-Content $PidFile
        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue
        if ($process) {
            Write-Host "$AppName is running with PID: $processId"
            Write-Host "App URL: http://localhost:$AppPort"
        }
        else {
            Write-Host "PID file exists but process is not running. App may have crashed."
        }
    }
    else {
        Write-Host "$AppName is not running"
    }
}

function Show-Logs {
    if (Test-Path $LogFile) {
        Get-Content $LogFile -Wait
    }
    else {
        Write-Host "Log file not found"
    }
}

# Main script
param(
    [Parameter(Position=0)]
    [ValidateSet("start", "stop", "restart", "status", "logs")]
    [string]$Action = "status"
)

switch ($Action) {
    "start" {
        Start-App
    }
    "stop" {
        Stop-App
    }
    "restart" {
        Stop-App
        Start-App
    }
    "status" {
        Get-AppStatus
    }
    "logs" {
        Show-Logs
    }
    default {
        Write-Host "Usage: .\start-app.ps1 {start|stop|restart|status|logs}"
    }
} 