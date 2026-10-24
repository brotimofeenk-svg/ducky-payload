# Принудительно подгружаем библиотеки для GUI
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# Создаем форму
$form = New-Object System.Windows.Forms.Form
$form.Text = "Панель управления (GitHub Edition)"
$form.Size = New-Object System.Drawing.Size(500, 450)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)

# Функция для быстрого создания кнопок
function Create-MyButton($text, $y, $clickAction) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $text
    $btn.Size = New-Object System.Drawing.Size(400, 35)
    $btn.Location = New-Object System.Drawing.Point(40, $y)
    $btn.BackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
    $btn.ForeColor = [System.Drawing.Color]::White
    $btn.FlatStyle = 'Flat'
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $btn.Add_Click($clickAction)
    $form.Controls.Add($btn)
}

# 1. Кнопка Тест
Create-MyButton "1. Тест" 20 {
    [System.Windows.Forms.MessageBox]::Show("Тест пройден!", "Уведомление")
}

# 2. Кнопка Скачать
Create-MyButton "2. Скачать файл" 65 {
    [System.Windows.Forms.MessageBox]::Show("Тут будет скачивание.", "Уведомление")
}

# 3. Кнопка Блокнот
Create-MyButton "3. Открыть блокнот" 110 {
    Start-Process notepad
}

# 4. Кнопка Поиска файлов
Create-MyButton "4. Найти текстовые файлы на ПК" 155 {
    $comboFiles.Items.Clear()
    $comboFiles.Items.Add("Сканирование...")
    $form.Refresh()
    
    $userPath = $env:USERPROFILE 
    # Ищем txt файлы, пропускаем AppData и скрытые папки
    $files = Get-ChildItem -Path $userPath -Filter "*.txt" -Recurse -File -ErrorAction SilentlyContinue | 
             Where-Object { $_.FullName -notmatch '\\AppData\\' -and $_.FullName -notmatch '\\\.' }
    
    $comboFiles.Items.Clear()
    
    if ($files) {
        foreach ($f in $files) {
            $comboFiles.Items.Add($f.FullName)
        }
    } else {
        $comboFiles.Items.Add("Файлы .txt не найдены")
    }
}

# Выпадающий список
$comboFiles = New-Object System.Windows.Forms.ComboBox
$comboFiles.Size = New-Object System.Drawing.Size(400, 30)
$comboFiles.Location = New-Object System.Drawing.Point(40, 210)
$comboFiles.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$comboFiles.ForeColor = [System.Drawing.Color]::White
$comboFiles.DropDownStyle = 'DropDownList'
$comboFiles.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($comboFiles)

# 5. Кнопка Выход
Create-MyButton "5. Выход" 360 {
    $form.Close()
}

# Запуск окна
[void]$form.ShowDialog()
