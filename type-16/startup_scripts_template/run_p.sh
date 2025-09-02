#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_P:-YOUR_API_KEY_FOR_P}" # ★★★ 環境変数GEMINI_API_KEY_Pを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_P:-YOUR_API_KEY_FOR_P}" # ★★★ 環境変数CLAUDE_API_KEY_Pを設定 ★★★
clear
bat --paging=always ../instructions/p_worker.md
echo "PANE 'p' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL