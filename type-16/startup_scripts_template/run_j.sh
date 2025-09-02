#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_J:-YOUR_API_KEY_FOR_J}" # ★★★ 環境変数GEMINI_API_KEY_Jを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_J:-YOUR_API_KEY_FOR_J}" # ★★★ 環境変数CLAUDE_API_KEY_Jを設定 ★★★
clear
bat --paging=always ../instructions/j_worker.md
echo "PANE 'j' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL