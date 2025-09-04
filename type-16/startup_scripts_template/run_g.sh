#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_G:-YOUR_API_KEY_FOR_G}" # ★★★ 環境変数GEMINI_API_KEY_Gを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_G:-YOUR_API_KEY_FOR_G}" # ★★★ 環境変数CLAUDE_API_KEY_Gを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/g_worker.md
echo "PANE 'g' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL