#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_K:-YOUR_API_KEY_FOR_K}" # ★★★ 環境変数GEMINI_API_KEY_Kを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_K:-YOUR_API_KEY_FOR_K}" # ★★★ 環境変数CLAUDE_API_KEY_Kを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/k_worker.md
echo "PANE 'k' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL