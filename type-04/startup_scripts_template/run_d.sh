#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数GEMINI_API_KEY_Dを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数CLAUDE_API_KEY_Dを設定 ★★★
clear
bat --paging=always ../instructions/d_worker.md
echo "PANE 'd' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL