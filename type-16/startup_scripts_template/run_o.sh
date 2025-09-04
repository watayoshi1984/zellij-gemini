#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_O:-YOUR_API_KEY_FOR_O}" # ★★★ 環境変数GEMINI_API_KEY_Oを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_O:-YOUR_API_KEY_FOR_O}" # ★★★ 環境変数CLAUDE_API_KEY_Oを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/o_worker.md
echo "PANE 'o' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL