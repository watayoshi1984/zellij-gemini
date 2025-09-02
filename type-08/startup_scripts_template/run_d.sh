#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_D:-YOUR_API_KEY_FOR_D}" # ★★★ 環境変数GEMINI_API_KEY_Dを設定 ★★★
clear
bat --paging=never ../instructions/d_worker.md
echo "PANE 'd' (Implementation Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorker Dです。実装・開発専門として、Technical Bossからの指示に基づき実装分析を行い、Technical Bossに報告します。"