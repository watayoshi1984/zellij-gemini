# master-setup.ps1
# このスクリプトは、WSLを起動し、指定されたTmuxレイアウトでセッションを開始します。

Write-Host "Starting Tmux Gemini Project Environment in WSL..." -ForegroundColor Green

# このスクリプトが置かれているディレクトリのWindowsパスを取得
$windowsPath = $PSScriptRoot

# WindowsパスをWSLが認識できるLinuxパスに変換
try {
    $wslPath = wsl.exe wslpath -u $windowsPath
} catch {
    Write-Host "Error: Failed to convert Windows path to WSL path." -ForegroundColor Red
    Write-Host "Please ensure WSL is installed and running correctly." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# 利用可能なTmuxレイアウトタイプを表示
Write-Host "\n=== Available Tmux Layout Types ===" -ForegroundColor Cyan
Write-Host "type-04: 4-pane layout (President + 3 specialists)" -ForegroundColor White
Write-Host "type-06: 6-pane layout (President + 5 specialists)" -ForegroundColor White
Write-Host "type-08: 8-pane layout (President + 7 specialists)" -ForegroundColor White
Write-Host "type-16: 16-pane layout (President + 15 specialists)" -ForegroundColor White
Write-Host "\n=== Usage Instructions ===" -ForegroundColor Cyan
Write-Host "1. Choose a layout type (type-04, type-06, type-08, or type-16)" -ForegroundColor White
Write-Host "2. Navigate to the chosen directory in WSL" -ForegroundColor White
Write-Host "3. Run the master-setup.ps1 script in that directory" -ForegroundColor White
Write-Host "\nExample:" -ForegroundColor Yellow
Write-Host "cd '$wslPath/type-04'" -ForegroundColor Green
Write-Host "./master-setup.ps1" -ForegroundColor Green

# WSL内で実行する一連のコマンドを定義
# 1. WSLパスに移動 (cd)
# 2. 共通スクリプトに実行権限を付与 (chmod)
# 3. 使用方法を表示
$command = "cd '$wslPath' && chmod +x *.sh && echo '' && echo '=== Tmux Gemini Squad Setup ===' && echo 'Available layout types:' && echo '  type-04: 4-pane layout' && echo '  type-06: 6-pane layout' && echo '  type-08: 8-pane layout' && echo '  type-16: 16-pane layout' && echo '' && echo 'To start a specific layout:' && echo '  cd type-XX  # Replace XX with 04, 06, 08, or 16' && echo '  ./master-setup.ps1' && echo '' && echo 'Common commands available in all layouts:' && echo '  ask_simple.sh   - Broadcast question to all panes' && echo '  ask_flat.sh     - Direct coordination (flat hierarchy)' && echo '  ask_tree.sh     - Hierarchical delegation (where available)' && echo ''"

# WSLを起動し、上記コマンドを実行
wsl.exe -- bash -c $command

Write-Host "\nTmux environment prepared. Check your WSL terminal window." -ForegroundColor Green
Write-Host "Navigate to your desired layout directory (type-04, type-06, type-08, or type-16)" -ForegroundColor Yellow
Write-Host "and run './master-setup.ps1' to start the Tmux session." -ForegroundColor Yellow

# ユーザーに次のステップを促す
Write-Host "\nPress Enter to open WSL terminal in the t-mux directory..." -ForegroundColor Cyan
Read-Host

# WSLターミナルを開く
Start-Process wsl.exe -ArgumentList "--cd", "'$wslPath'"