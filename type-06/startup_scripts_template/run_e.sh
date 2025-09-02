#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_E:-YOUR_API_KEY_FOR_E}" # ★★★ 環境変数GEMINI_API_KEY_Eを設定 ★★★
clear
bat --paging=never ../instructions/e_worker.md
echo "PANE 'e' (Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorkerです。Boss Bからタスクを受け取り、具体的な作業を実行します。"