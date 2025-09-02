#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数GEMINI_API_KEY_Cを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数CLAUDE_API_KEY_Cを設定 ★★★
clear
bat --paging=always ../instructions/c_boss.md
echo "PANE 'c' (Boss) IS READY. (Press 'q' to exit viewer)"
exec $SHELL