#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_B:-YOUR_API_KEY_FOR_B}" # ★★★ 環境変数GEMINI_API_KEY_Bを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_B:-YOUR_API_KEY_FOR_B}" # ★★★ 環境変数CLAUDE_API_KEY_Bを設定 ★★★

# Geminiセッションを開始
echo "Starting Gemini session for Worker B..."
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

clear
/usr/local/bin/bat --paging=always ../instructions/b_worker.md
echo "PANE 'b' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL