#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_C:-YOUR_API_KEY_FOR_C}" # ★★★ 環境変数GEMINI_API_KEY_Cを設定 ★★★
clear
bat --paging=never ../instructions/c_worker.md
echo "PANE 'c' (System Design Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorker Cです。システム設計・アーキテクチャ専門として、Technical Bossからの指示に基づき技術設計を行い、Technical Bossに報告します。"