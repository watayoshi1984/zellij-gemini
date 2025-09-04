#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数GEMINI_API_KEY_Aを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数CLAUDE_API_KEY_Aを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/a_president.md
echo "PANE 'a' (President) IS READY. (Press 'q' to exit viewer)"
exec $SHELL