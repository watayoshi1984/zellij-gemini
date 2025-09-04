#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_I:-YOUR_API_KEY_FOR_I}" # ★★★ 環境変数GEMINI_API_KEY_Iを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_I:-YOUR_API_KEY_FOR_I}" # ★★★ 環境変数CLAUDE_API_KEY_Iを設定 ★★★
clear
/usr/local/bin/bat --paging=always ../instructions/i_worker.md
echo "PANE 'i' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL