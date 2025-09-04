# master-setup.ps1 - type-08 tmux版起動スクリプト（改良版 - クリーンアップ機能付き）
# このスクリプトは、起動前に既存のセッションやプロセスをクリーンアップし、常にクリーンな状態でtmuxを起動します。

$sessionName = "gemini-squad-8" # tmux_layout.shで定義したセッション名
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
Write-Host "Step 2: Starting new Tmux Gemini Project Environment (type-08) in WSL..." -ForegroundColor Cyan

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

Write-Host "📂 Current directory: $windowsPath" -ForegroundColor Green
Write-Host "🐧 WSL path: $wslPath" -ForegroundColor Green
Write-Host ""

# Prepare WSL commands
$wslCommands = @(
    "cd '$wslPath/t-mux/type-08'",
    "echo '🔧 Setting up Type-08 environment...'",
    "chmod +x tmux_layout.sh ask_tree.sh",
    "chmod +x startup_scripts_template/*.sh",
    "echo ''",
    "echo '📋 Checking tmux installation...'",
    "if command -v tmux >/dev/null 2>&1; then",
    "    echo '✅ tmux is available'",
    "    tmux -V",
    "else",
    "    echo '❌ tmux not found. Installing...'",
    "    sudo apt-get update && sudo apt-get install -y tmux",
    "fi",
    "echo ''",
    "echo '🎯 Gemini Squad Type-08 Ready!'",
    "echo ''",
    "echo '📊 Architecture Overview:'",
    "echo '  President-a (Strategic Decision Maker)'",
    "echo '  ├── TechBoss-b (Technical Group Leader)'",
    "echo '  │   ├── SysDesign-c (System Architecture)'",
    "echo '  │   ├── Implement-d (Development)'",
    "echo '  │   └── Quality-e (QA & Testing)'",
    "echo '  └── BizBoss-f (Business Group Leader)'",
    "echo '      ├── Market-g (Market Analysis)'",
    "echo '      └── Strategy-h (Business Strategy)'",
    "echo ''",
    "echo '⚙️  SETUP STEPS:'",
    "echo ''",
    "echo '1. 🔑 Configure API Keys:'",
    "echo '   Edit ../load_env.sh and set:'",
    "echo '   - GEMINI_API_KEY_A (President)'",
    "echo '   - GEMINI_API_KEY_B (Technical Boss)'",
    "echo '   - GEMINI_API_KEY_C (System Design)'",
    "echo '   - GEMINI_API_KEY_D (Implementation)'",
    "echo '   - GEMINI_API_KEY_E (Quality Assurance)'",
    "echo '   - GEMINI_API_KEY_F (Business Boss)'",
    "echo '   - GEMINI_API_KEY_G (Market Analysis)'",
    "echo '   - GEMINI_API_KEY_H (Business Strategy)'",
    "echo ''",
    "echo '2. 🚀 Create Tmux Session:'",
    "echo '   ./tmux_layout.sh'",
    "echo ''",
    "echo '3. 🔗 Attach to Session:'",
    "echo '   tmux attach-session -t gemini-squad-8'",
    "echo ''",
    "echo '4. 🎯 Execute Hierarchical Tasks:'",
    "echo '   ./ask_tree.sh \"Your strategic question\"'",
    "echo ''",
    "echo '📋 Pane Layout:'",
    "echo '  ┌─────────────┬─────────────┐'",
    "echo '  │ President-a │ TechBoss-b  │'",
    "echo '  ├─────────────┼─────┬───────┤'",
    "echo '  │ BizBoss-f   │ Sys │ Impl  │'",
    "echo '  ├─────┬───────┤ Des │ ement │'",
    "echo '  │ Mkt │ Strat ├─────┼───────┤'",
    "echo '  │ -g  │ -h    │ -c  │ Qual-e│'",
    "echo '  └─────┴───────┴─────┴───────┘'",
    "echo ''",
    "echo '🎛️  Navigation:'",
    "echo '   Ctrl+b, q, 0: President-a'",
    "echo '   Ctrl+b, q, 1: TechBoss-b'",
    "echo '   Ctrl+b, q, 2-4: Technical Workers (c,d,e)'",
    "echo '   Ctrl+b, q, 5: BizBoss-f'",
    "echo '   Ctrl+b, q, 6-7: Business Workers (g,h)'",
    "echo ''",
    "echo '💡 Features:'",
    "echo '   • Dual-axis analysis (Technical + Business)'",
    "echo '   • Hierarchical task delegation'",
    "echo '   • Integrated reporting system'",
    "echo '   • Strategic decision synthesis'",
    "echo ''",
    "echo '🚀 Ready for comprehensive dual-perspective analysis!'",
    "echo ''"
)

# Join commands with semicolons
$wslCommandString = $wslCommands -join "; "

Write-Host "🐧 Executing WSL setup commands..." -ForegroundColor Cyan
Write-Host ""

# Execute in WSL
wsl bash -c $wslCommandString

Write-Host ""
Write-Host "✅ Type-08 setup completed!" -ForegroundColor Green
Write-Host ""

# Ask if user wants to open WSL terminal
$openWSL = Read-Host "Would you like to open a WSL terminal in the Type-08 directory? (y/n)"
if ($openWSL -eq 'y' -or $openWSL -eq 'Y') {
    Write-Host "🚀 Opening WSL terminal..." -ForegroundColor Green
    Start-Process wsl -ArgumentList "bash", "-c", "cd '$wslPath/t-mux/type-08' && bash"
}

Write-Host ""
Write-Host "📚 Quick Reference:" -ForegroundColor Yellow
Write-Host "   Setup: ./tmux_layout.sh" -ForegroundColor White
Write-Host "   Attach: tmux attach-session -t gemini-squad-8" -ForegroundColor White
Write-Host "   Execute: ./ask_tree.sh \"Your question\"" -ForegroundColor White
Write-Host "   Detach: Ctrl+b, d" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Type-08: Dual-axis hierarchical analysis ready!" -ForegroundColor Magenta