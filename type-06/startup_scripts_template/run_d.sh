#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数GEMINI_API_KEY_Dを設定 ★★★
clear
bat --paging=never ../instructions/d_worker.md
echo "PANE 'd' (Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorkerです。Boss Bからタスクを受け取り、具体的な作業を実行します。"