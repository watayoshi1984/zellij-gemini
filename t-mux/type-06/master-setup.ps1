# master-setup.ps1 - type-06 tmux版起動スクリプト（改良版 - クリーンアップ機能付き）
# このスクリプトは、起動前に既存のセッションやプロセスをクリーンアップし、常にクリーンな状態でtmuxを起動します。

$sessionName = "gemini-squad-6" # tmux_layout.shで定義したセッション名
$portsToClean = @("8080", "9001", "9002", "9003") # クリーンアップ対象のポートリスト

# --- ステップ 1: 事前クリーンアップ ---
Write-Host "Step 1: Cleaning up previous sessions and processes in WSL..." -ForegroundColor Yellow

# 既存のtmuxセッションを終了
Write-Host " -> Killing existing tmux session: $sessionName"
wsl.exe -- tmux kill-session -t $sessionName 2>$null

# 使用中のポートをクリーンアップ
foreach ($port in $portsToClean) {
    Write-Host " -> Cleaning up port: $port"
    # lsofでPIDを取得し、xargsでkillに渡す。プロセスが存在しない場合のエラーは無視する
    wsl.exe -- bash -c "sudo lsof -t -i:$port 2>/dev/null | xargs -r kill -9 2>/dev/null" 2>$null
}

Write-Host "Cleanup complete." -ForegroundColor Green
Start-Sleep -Seconds 2 # 念のため少し待機

# --- ステップ 2: tmux環境の起動 ---
Write-Host "Step 2: Starting new Tmux Gemini Project Environment (type-06) in WSL..." -ForegroundColor Cyan

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
$setupCommands = @(
    "cd '$wslPath'",
    "chmod +x startup_scripts_template/*.sh ask_tree.sh tmux_layout.sh",
    "echo 'Setting up tmux environment...'",
    "# tmuxがインストールされているかチェック",
    "if ! command -v tmux &> /dev/null; then",
    "    echo 'Error: tmux is not installed. Please install tmux first.'",
    "    echo 'Install command: sudo apt-get update && sudo apt-get install tmux'",
    "    exit 1",
    "fi",
    "echo 'tmux version:'",
    "tmux -V",
    "echo ''",
    "echo 'Type-06: 6-pane Hierarchical Structure'",
    "echo 'Structure: President(a) -> Boss(b) -> Workers(c,d,e,f)'",
    "echo ''",
    "echo 'Please set your API keys in the following files:'",
    "echo '  - startup_scripts_template/run_a.sh (President)'",
    "echo '  - startup_scripts_template/run_b.sh (Boss)'",
    "echo '  - startup_scripts_template/run_c.sh (Worker C - Tech)'",
    "echo '  - startup_scripts_template/run_d.sh (Worker D - Market)'",
    "echo '  - startup_scripts_template/run_e.sh (Worker E - Strategy)'",
    "echo '  - startup_scripts_template/run_f.sh (Worker F - Risk)'",
    "echo ''",
    "echo 'After setting API keys, run the following commands:'",
    "echo '  1. ./tmux_layout.sh    # Create 6-pane hierarchical tmux session'",
    "echo '  2. tmux attach-session -t gemini-squad-6    # Attach to session'",
    "echo '  3. In President pane: ./ask_tree.sh \"your question\"    # Start hierarchical task'",
    "echo ''",
    "echo 'Hierarchy Overview:'",
    "echo '  ┌─────────────┬─────────────┐'",
    "echo '  │             │   Boss-b    │'",
    "echo '  │ President-a ├──────┬──────┤'",
    "echo '  │             │ Wkr-c│ Wkr-d│'",
    "echo '  │             ├──────┼──────┤'",
    "echo '  │             │ Wkr-e│ Wkr-f│'",
    "echo '  └─────────────┴──────┴──────┘'",
    "echo ''",
    "echo 'Tmux basic commands:'",
    "echo '  - Switch panes: Ctrl+b + Arrow keys'",
    "echo '  - Detach session: Ctrl+b + d'",
    "echo '  - List sessions: tmux list-sessions'",
    "echo '  - Kill session: tmux kill-session -t gemini-squad-6'"
)

# コマンドを結合
$command = $setupCommands -join " && "

Write-Host "Executing setup commands in WSL..." -ForegroundColor Yellow

# WSLを起動し、セットアップコマンドを実行
try {
    wsl.exe -- bash -c $command
    
    Write-Host "" -ForegroundColor Green
    Write-Host "Setup completed successfully!" -ForegroundColor Green
    Write-Host "" -ForegroundColor Green
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Set your API keys in the startup_scripts_template/*.sh files" -ForegroundColor White
    Write-Host "2. Run './tmux_layout.sh' in WSL to create the 6-pane hierarchical session" -ForegroundColor White
    Write-Host "3. Use 'tmux attach-session -t gemini-squad-6' to attach to the session" -ForegroundColor White
    Write-Host "4. In President pane, use './ask_tree.sh \"question\"' to start hierarchical analysis" -ForegroundColor White
    Write-Host "" -ForegroundColor Green
    Write-Host "Hierarchical Structure:" -ForegroundColor Magenta
    Write-Host "- President (a): Overall leadership and final decisions" -ForegroundColor White
    Write-Host "- Boss (b): Middle management, coordinates all workers" -ForegroundColor White
    Write-Host "- Worker C: Technical analysis specialist" -ForegroundColor White
    Write-Host "- Worker D: Market analysis specialist" -ForegroundColor White
    Write-Host "- Worker E: Strategy analysis specialist" -ForegroundColor White
    Write-Host "- Worker F: Risk analysis specialist" -ForegroundColor White
    Write-Host "" -ForegroundColor Green
    
    # ユーザーに次のアクションを確認
    $response = Read-Host "Do you want to open WSL terminal now? (y/N)"
    if ($response -match '^[Yy]$') {
        Write-Host "Opening WSL terminal..." -ForegroundColor Green
        wsl.exe -- bash -c "cd '$wslPath' && exec bash"
    }
    
} catch {
    Write-Host "Error occurred during setup: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please check your WSL installation and try again." -ForegroundColor Red
    Read-Host "Press Enter to exit"
}

Write-Host "Script execution completed." -ForegroundColor Green