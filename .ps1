Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Панель управления"
$form.Size = New-Object System.Drawing.Size(500, 450) # Окно чуть больше
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedSingle'
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)

function Create-Button($text, $yPos) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $text
    $btn.Size = New-Object System.Drawing.Size(400, 35)
    $btn.Location = New-Object System.Drawing.Point(40, $yPos)
    $btn.BackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
    $btn.ForeColor = [System.Drawing.Color]::White
    $btn.FlatStyle = 'Flat'
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    return $btn
}

# --- Кнопки ---
$btn1 = Create-Button "1. Тест" 20
$btn1.Add_Click({ [System.Windows.Forms.MessageBox]::Show("Тест!", "Уведомление") })
$form.Controls.Add($btn1)

$btn2 = Create-Button "2. Скачать файл" 65
$btn2.Add_Click({ [System.Windows.Forms.MessageBox]::Show("Тут будет скачивание.", "Уведомление") })
$form.Controls.Add($btn2)

$btn3 = Create-Button "3. Открыть блокнот" 110
$btn3.Add_Click({ Start-Process notepad })
$form.Controls.Add($btn3)

# --- НОВАЯ КНОПКА ПОИСКА ---
$btnScan = Create-Button "4. Найти текстовые файлы на ПК" 155
$form.Controls.Add($btnScan)

# Создаем выпадающий список (ComboBox)
$comboFiles = New-Object System.Windows.Forms.ComboBox
$comboFiles.Size = New-Object System.Drawing.Size(400, 30)
$comboFiles.Location = New-Object System.Drawing.Point(40, 210)
$comboFiles.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$comboFiles.ForeColor = [System.Drawing.Color]::White
$comboFiles.DropDownStyle = 'DropDownList' # Чтобы нельзя было вводить свой текст
$comboFiles.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($comboFiles)

# Логика сканирования
$btnScan.Add_Click({
    $comboFiles.Items.Clear()
    $comboFiles.Items.Add("Сканирование...")
    
    # Папка пользователя (Desktop, Documents, Downloads и т.д.)
    $userPath = $env:USERPROFILE 
    
    # Ищем txt файлы. Отсекаем скрытые папки (AppData, .git и т.д.)
    $files = Get-ChildItem -Path $userPath -Filter "*.txt" -Recurse -File -ErrorAction SilentlyContinue | 
             Where-Object { $_.FullName -notmatch '\\AppData\\' -and $_.FullName -notmatch '\\\.' }
    
    $comboFiles.Items.Clear()
    
    if ($files) {
        foreach ($f in $files) {
            # Выводим имя файла, а путь сохраняем в скрытом свойстве
            $comboFiles.Items.Add($f.Name) | Out-Null
        }
    } else {
        $comboFiles.Items.Add("Файлы .txt не найдены") | Out-Null
    }
})

# Кнопка Выход
$btn4 = Create-Button "5. Выход" 360
$btn4.Add_Click({ $form.Close() })
$form.Controls.Add($btn4)

$form.ShowDialog()
