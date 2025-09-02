#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_H:-YOUR_API_KEY_FOR_H}" # ★★★ 環境変数GEMINI_API_KEY_Hを設定 ★★★
clear
bat --paging=never ../instructions/h_worker.md
echo "PANE 'h' (Business Strategy Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorker Hです。事業戦略専門として、Business Bossからの指示に基づき戦略立案を行い、Business Bossに報告します。"