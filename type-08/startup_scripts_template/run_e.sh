#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_E:-YOUR_API_KEY_FOR_E}" # ★★★ 環境変数GEMINI_API_KEY_Eを設定 ★★★
clear
bat --paging=never ../instructions/e_worker.md
echo "PANE 'e' (Quality Assurance Worker) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はWorker Eです。品質保証・テスト専門として、Technical Bossからの指示に基づき品質分析を行い、Technical Bossに報告します。"