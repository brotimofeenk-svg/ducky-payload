# 1. Красивое появление (эмуляция загрузки библиотек)
$libs = @(
    "System.Net.Http.dll",
    "System.Security.Cryptography.dll",
    "Newtonsoft.Json.dll",
    "Discord.Net.Core.dll"
)

Write-Host "Инициализация среды..." -ForegroundColor DarkGray
Start-Sleep -Milliseconds 500

foreach ($lib in $libs) {
    Write-Host "Загрузка библиотеки: $lib ..." -ForegroundColor Cyan -NoNewline
    # Имитация прогресс-бара
    for ($i = 0; $i -le 100; $i += 20) {
        Write-Host " [■■■■■□□□□□] $i%" -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 100
        Write-Host "`r" -NoNewline
    }
    Write-Host " [■■■■■■■■■■] 100% - OK" -ForegroundColor Green
    Start-Sleep -Milliseconds 200
}

Write-Host "`nВсе библиотеки загружены. Начинаю скачивание файла..." -ForegroundColor Magenta
Start-Sleep -Seconds 1

# 2. Сама загрузка файла (качаем безобидную картинку на Рабочий стол)
$url = "https://raw.githubusercontent.com/github/explore/main/topics/powershell/powershell.png"
$dest = "$env:USERPROFILE\Desktop\downloaded_file.png"

try {
    (New-Object System.Net.WebClient).DownloadFile($url, $dest)
    Write-Host "Файл успешно скачан: $dest" -ForegroundColor Green
} catch {
    Write-Host "Ошибка скачивания: $_" -ForegroundColor Red
}

Start-Sleep -Seconds 2
