#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_E:-YOUR_API_KEY_FOR_E}" # ★★★ 環境変数GEMINI_API_KEY_Eを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_E:-YOUR_API_KEY_FOR_E}" # ★★★ 環境変数CLAUDE_API_KEY_Eを設定 ★★★

# Geminiセッションを開始
echo "Starting Gemini session for Worker E..."
gemini session start

clear
/usr/local/bin/bat --paging=always ../instructions/e_worker.md
echo "PANE 'e' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL