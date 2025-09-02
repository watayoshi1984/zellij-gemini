# master-setup.ps1
# このスクリプトは、WSLを起動し、指定されたZellijレイアウトでセッションを開始します。

Write-Host "Starting Zellij Gemini Project Environment in WSL..." -ForegroundColor Green

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

# WSL内で実行する一連のコマンドを定義
# 1. WSLパスに移動 (cd)
# 2. 起動スクリプトに実行権限を付与 (chmod)
# 3. 各ワーカーのAPIキー設定を促す
# 4. Zellijをレイアウトファイル付きで起動
$command = "cd '$wslPath' && chmod +x startup_scripts/*.sh ask_tree.sh && echo 'Please set your API keys (Gemini or Claude) in the startup_scripts/run_*.sh files.' && echo 'After setting the API keys, run the following command to start Zellij:' && echo 'zellij --layout layout.yaml'"

# WSLを起動し、上記コマンドを実行
wsl.exe -- bash -c $command

Write-Host "Zellij session started. Check your WSL terminal window." -ForegroundColor Green
Write-Host "Please set your API keys (Gemini or Claude) in the startup_scripts/run_*.sh files." -ForegroundColor Yellow
Write-Host "After setting the API keys, run 'zellij --layout layout.yaml' in the WSL terminal." -ForegroundColor Yellow