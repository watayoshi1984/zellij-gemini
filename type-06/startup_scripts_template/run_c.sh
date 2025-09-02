#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数GEMINI_API_KEY_Cを設定 ★★★
clear
bat --paging=never ../instructions/c_worker.md
echo "PANE 'c' (Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorkerです。Boss Bからタスクを受け取り、具体的な作業を実行します。"