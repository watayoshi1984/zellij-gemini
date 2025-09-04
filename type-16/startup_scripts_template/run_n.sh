#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_N:-YOUR_API_KEY_FOR_N}" # ★★★ 環境変数GEMINI_API_KEY_Nを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_N:-YOUR_API_KEY_FOR_N}" # ★★★ 環境変数CLAUDE_API_KEY_Nを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/n_worker.md
echo "PANE 'n' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL