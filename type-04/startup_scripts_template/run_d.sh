#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数GEMINI_API_KEY_Dを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数CLAUDE_API_KEY_Dを設定 ★★★

# Geminiセッションを開始
echo "Starting Gemini session for Worker D..."

echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

sleep 1
clear

/usr/local/bin/bat --paging=always instructions/d_worker.md
echo "PANE 'd' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL