$steps = @(
  "Fetching dependencies",
  "Resolving NuGet packages",
  "Downloading 12/48",
  "Verifying signatures",
  "Linking assemblies",
  "Initializing runtime"
)

foreach ($s in $steps) {
  Start-Process cmd -ArgumentList '/c', "echo $s && timeout /t 2 >nul" -WindowStyle Normal
  Start-Sleep -Milliseconds 800
}

Start-Sleep -Seconds 2

1..3 | ForEach-Object { Start-Process notepad; Start-Sleep -Milliseconds 500 }

Start-Sleep -Seconds 5

Get-Process cmd, notepad -ErrorAction SilentlyContinue | Stop-Process -Force
