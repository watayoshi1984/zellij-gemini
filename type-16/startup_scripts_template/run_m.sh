#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_M:-YOUR_API_KEY_FOR_M}" # ★★★ 環境変数GEMINI_API_KEY_Mを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_M:-YOUR_API_KEY_FOR_M}" # ★★★ 環境変数CLAUDE_API_KEY_Mを設定 ★★★
clear
bat --paging=always ../instructions/m_worker.md
echo "PANE 'm' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL