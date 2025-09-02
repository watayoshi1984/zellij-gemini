#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_H:-YOUR_API_KEY_FOR_H}" # ★★★ 環境変数GEMINI_API_KEY_Hを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_H:-YOUR_API_KEY_FOR_H}" # ★★★ 環境変数CLAUDE_API_KEY_Hを設定 ★★★
clear
bat --paging=always ../instructions/h_worker.md
echo "PANE 'h' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL