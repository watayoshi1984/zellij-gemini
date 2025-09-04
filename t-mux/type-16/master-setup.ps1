# master-setup.ps1 - type-16 tmux版起動スクリプト（改良版 - クリーンアップ機能付き）
# このスクリプトは、起動前に既存のセッションやプロセスをクリーンアップし、常にクリーンな状態でtmuxを起動します。

$sessionName = "gemini-squad-16" # tmux_layout.shで定義したセッション名
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
Write-Host "Step 2: Starting new Tmux Gemini Project Environment (type-16) in WSL..." -ForegroundColor Cyan

# Get current directory and convert to WSL path
$currentDir = Get-Location
$wslPath = $currentDir.Path -replace '^([A-Z]):', '/mnt/$1' -replace '\\', '/' | ForEach-Object { $_.ToLower() }

Write-Host "📁 Current Directory: $currentDir" -ForegroundColor Yellow
Write-Host "🐧 WSL Path: $wslPath" -ForegroundColor Yellow
Write-Host ""

# Make scripts executable
Write-Host "🔧 Making scripts executable..." -ForegroundColor Blue
wsl chmod +x "$wslPath/tmux_layout.sh"
wsl chmod +x "$wslPath/ask_tree.sh"
wsl chmod +x "$wslPath/ask_flat.sh"
wsl chmod +x "$wslPath/../ask_simple.sh"
wsl chmod +x "$wslPath/startup_scripts_template/*.sh"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Scripts made executable" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to make scripts executable" -ForegroundColor Red
    exit 1
}

# Check if Tmux is installed
Write-Host "🔍 Checking Tmux installation..." -ForegroundColor Blue
$tmuxCheck = wsl which tmux 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Tmux not found. Installing..." -ForegroundColor Yellow
    wsl sudo apt update
    wsl sudo apt install -y tmux
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Tmux installed successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to install Tmux" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ Tmux is already installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "🏗️  TYPE-16 ENTERPRISE ARCHITECTURE OVERVIEW" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 Organizational Structure (4x4 Grid):" -ForegroundColor White
Write-Host ""
Write-Host "   ┌─────────────┬─────────────┬─────────────┬─────────────┐" -ForegroundColor Gray
Write-Host "   │ President   │ Tech Boss   │ Sys Arch    │ Lead Dev    │" -ForegroundColor White
Write-Host "   │    (0)      │    (1)      │    (2)      │    (3)      │" -ForegroundColor Gray
Write-Host "   ├─────────────┼─────────────┼─────────────┼─────────────┤" -ForegroundColor Gray
Write-Host "   │ DevOps Eng  │ Security    │ Data Arch   │ Quality Eng │" -ForegroundColor White
Write-Host "   │    (4)      │    (5)      │    (6)      │    (7)      │" -ForegroundColor Gray
Write-Host "   ├─────────────┼─────────────┼─────────────┼─────────────┤" -ForegroundColor Gray
Write-Host "   │ Biz Boss    │ Strategy    │ Market      │ Finance     │" -ForegroundColor White
Write-Host "   │    (8)      │    (9)      │   (10)      │   (11)      │" -ForegroundColor Gray
Write-Host "   ├─────────────┼─────────────┼─────────────┼─────────────┤" -ForegroundColor Gray
Write-Host "   │ Operations  │ Product Mgr │ Customer    │ Compliance  │" -ForegroundColor White
Write-Host "   │   (12)      │   (13)      │   (14)      │   (15)      │" -ForegroundColor Gray
Write-Host "   └─────────────┴─────────────┴─────────────┴─────────────┘" -ForegroundColor Gray
Write-Host ""

Write-Host "🏗️  Technical Division (Panes 1-7):" -ForegroundColor Blue
Write-Host "   1️⃣  Technical Boss: Technical leadership and coordination" -ForegroundColor White
Write-Host "   2️⃣  System Architect: Enterprise architecture and design" -ForegroundColor White
Write-Host "   3️⃣  Lead Developer: Development leadership and standards" -ForegroundColor White
Write-Host "   4️⃣  DevOps Engineer: Infrastructure and deployment" -ForegroundColor White
Write-Host "   5️⃣  Security Specialist: Security architecture and compliance" -ForegroundColor White
Write-Host "   6️⃣  Data Architect: Data strategy and architecture" -ForegroundColor White
Write-Host "   7️⃣  Quality Engineer: Quality assurance and testing" -ForegroundColor White
Write-Host ""

Write-Host "💼 Business Division (Panes 8-15):" -ForegroundColor Magenta
Write-Host "   8️⃣  Business Boss: Business leadership and coordination" -ForegroundColor White
Write-Host "   9️⃣  Strategy Director: Strategic planning and execution" -ForegroundColor White
Write-Host "   🔟 Market Analyst: Market research and competitive analysis" -ForegroundColor White
Write-Host "   1️⃣1️⃣ Finance Director: Financial planning and analysis" -ForegroundColor White
Write-Host "   1️⃣2️⃣ Operations Manager: Operations and process optimization" -ForegroundColor White
Write-Host "   1️⃣3️⃣ Product Manager: Product strategy and roadmap" -ForegroundColor White
Write-Host "   1️⃣4️⃣ Customer Success: Customer experience and retention" -ForegroundColor White
Write-Host "   1️⃣5️⃣ Compliance Officer: Regulatory compliance and risk" -ForegroundColor White
Write-Host ""

Write-Host "⚙️  CONFIGURATION REQUIRED" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow
Write-Host ""
Write-Host "🔑 API Key Configuration:" -ForegroundColor White
Write-Host "   You need to set your Gemini API key for Type-16:" -ForegroundColor Gray
Write-Host "   export GEMINI_API_KEY_TYPE16='your-api-key-here'" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 You can add this to your ~/.bashrc or ~/.zshrc for persistence" -ForegroundColor Yellow
Write-Host ""

Write-Host "🚀 GETTING STARTED" -ForegroundColor Green
Write-Host "================" -ForegroundColor Green
Write-Host ""
Write-Host "1️⃣  Configure API Key:" -ForegroundColor White
Write-Host "   wsl export GEMINI_API_KEY_TYPE16='your-api-key-here'" -ForegroundColor Cyan
Write-Host ""
Write-Host "2️⃣  Create Tmux Session:" -ForegroundColor White
Write-Host "   wsl bash '$wslPath/tmux_layout.sh'" -ForegroundColor Cyan
Write-Host ""
Write-Host "3️⃣  Attach to Session:" -ForegroundColor White
Write-Host "   wsl tmux attach-session -t gemini-squad-16" -ForegroundColor Cyan
Write-Host ""
Write-Host "4️⃣  Execute Enterprise Tasks:" -ForegroundColor White
Write-Host "   wsl bash '$wslPath/ask_tree.sh' \"Your complex enterprise question\"" -ForegroundColor Cyan
Write-Host "   wsl bash '$wslPath/ask_flat.sh' \"Your strategic coordination question\"" -ForegroundColor Cyan
Write-Host ""

Write-Host "🎛️  PANE LAYOUT & NAVIGATION" -ForegroundColor Cyan
Write-Host "==========================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Pane Navigation (Ctrl+b, q, [number]):" -ForegroundColor White
Write-Host "   President: 0" -ForegroundColor Yellow
Write-Host "   Technical Division: 1-7" -ForegroundColor Blue
Write-Host "   Business Division: 8-15" -ForegroundColor Magenta
Write-Host ""
Write-Host "🔄 Workflow Commands:" -ForegroundColor White
Write-Host "   ask_tree.sh  - Hierarchical analysis (Boss → Workers)" -ForegroundColor Green
Write-Host "   ask_flat.sh  - Flat coordination (President → All)" -ForegroundColor Green
Write-Host "   ask_simple.sh - Broadcast to all panes" -ForegroundColor Green
Write-Host ""

Write-Host "🎯 ENTERPRISE USE CASES" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "🏗️  Large-scale digital transformation projects" -ForegroundColor White
Write-Host "🏛️  Complex system architecture decisions" -ForegroundColor White
Write-Host "📊 Multi-domain strategic planning" -ForegroundColor White
Write-Host "⚖️  Comprehensive risk and compliance assessment" -ForegroundColor White
Write-Host "🚀 Enterprise-wide technology adoption" -ForegroundColor White
Write-Host "💼 Organizational restructuring and optimization" -ForegroundColor White
Write-Host "🌐 Global market expansion strategies" -ForegroundColor White
Write-Host "🔄 Business process reengineering" -ForegroundColor White
Write-Host ""

Write-Host "📚 ADDITIONAL RESOURCES" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "🔧 Session Management:" -ForegroundColor White
Write-Host "   wsl bash '$wslPath/../session_manager.sh' help" -ForegroundColor Cyan
Write-Host ""
Write-Host "📖 Documentation:" -ForegroundColor White
Write-Host "   All scripts include built-in help and examples" -ForegroundColor Gray
Write-Host ""
Write-Host "🐛 Troubleshooting:" -ForegroundColor White
Write-Host "   Check logs in: ~/.gemini_squad/logs/" -ForegroundColor Gray
Write-Host ""

Write-Host "✅ Setup completed successfully!" -ForegroundColor Green
Write-Host ""

# --- ステップ 3: tmuxセッションの起動 ---
Write-Host "Step 3: Creating tmux session..." -ForegroundColor Cyan

# tmux_layout.shを実行してセッションを作成
try {
    wsl.exe -- bash "$wslPath/tmux_layout.sh"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Tmux session created successfully!" -ForegroundColor Green
        
        # セッションにアタッチするかユーザーに確認
        $response = Read-Host "🚀 Would you like to attach to the tmux session now? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Write-Host "🔗 Attaching to tmux session..." -ForegroundColor Green
            wsl.exe -- tmux attach-session -t $sessionName
        } else {
            Write-Host "💡 To attach later, run:" -ForegroundColor Yellow
            Write-Host "   wsl tmux attach-session -t $sessionName" -ForegroundColor Cyan
        }
    } else {
        Write-Host "❌ Failed to create tmux session" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
} catch {
    Write-Host "❌ Error executing tmux_layout.sh: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "🎯 Ready for enterprise-scale comprehensive analysis!" -ForegroundColor Green