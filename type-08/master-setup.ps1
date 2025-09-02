# master-setup.ps1
# type-08: 8分割（President + 2Boss + 5Worker）Zellijセッション起動スクリプト

Write-Host "Starting Zellij Gemini 8-Pane Hierarchy Project Environment in WSL..." -ForegroundColor Green

$windowsPath = $PSScriptRoot

try {
    $wslPath = wsl.exe wslpath -u $windowsPath
} catch {
    Write-Host "Error: Failed to convert Windows path to WSL path." -ForegroundColor Red
    Write-Host "Please ensure WSL is installed and running correctly." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

$command = "cd '$wslPath' && chmod +x startup_scripts/*.sh ask_tree.sh && echo 'Please set your API keys (Gemini or Claude) in the startup_scripts/run_*.sh files.' && echo 'After setting the API keys, run the following command to start Zellij:' && echo 'zellij --layout layout.yaml'"

wsl.exe -- bash -c $command

Write-Host "Zellij 8-pane session ready to start. Check your WSL terminal window." -ForegroundColor Green
Write-Host "Please set your API keys (Gemini or Claude) in the startup_scripts/run_*.sh files." -ForegroundColor Yellow
Write-Host "After setting the API keys, run 'zellij --layout layout.yaml' in the WSL terminal." -ForegroundColor Yellow