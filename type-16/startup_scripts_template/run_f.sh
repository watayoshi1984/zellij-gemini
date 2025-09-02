#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_F:-YOUR_API_KEY_FOR_F}" # ★★★ 環境変数GEMINI_API_KEY_Fを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_F:-YOUR_API_KEY_FOR_F}" # ★★★ 環境変数CLAUDE_API_KEY_Fを設定 ★★★
clear
bat --paging=always ../instructions/f_worker.md
echo "PANE 'f' (Worker) IS READY. (Press 'q' to exit viewer)"
exec $SHELL