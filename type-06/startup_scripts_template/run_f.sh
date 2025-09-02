#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_F:-YOUR_API_KEY_FOR_F}" # ★★★ 環境変数GEMINI_API_KEY_Fを設定 ★★★
clear
bat --paging=never ../instructions/f_worker.md
echo "PANE 'f' (Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorkerです。Boss Bからタスクを受け取り、具体的な作業を実行します。"