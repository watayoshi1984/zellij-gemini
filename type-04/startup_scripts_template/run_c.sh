#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数GEMINI_API_KEY_Cを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数CLAUDE_API_KEY_Cを設定 ★★★

# Geminiセッションを開始
echo "Starting Gemini session for Worker C..."
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

clear
/usr/local/bin/bat --paging=always ../instructions/c_worker.md
echo "PANE 'c' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL