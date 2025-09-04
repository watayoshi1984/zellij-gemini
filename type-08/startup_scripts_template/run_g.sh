#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_G:-YOUR_API_KEY_FOR_G}" # ★★★ 環境変数GEMINI_API_KEY_Gを設定 ★★★
clear
/usr/local/bin/bat --paging=never ../instructions/g_worker.md
echo "PANE 'g' (Market Analysis Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorker Gです。市場分析専門として、Business Bossからの指示に基づき市場調査を行い、Business Bossに報告します。"