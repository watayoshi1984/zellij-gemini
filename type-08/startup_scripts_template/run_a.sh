#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数GEMINI_API_KEY_Aを設定 ★★★
clear
/usr/local/bin/bat --paging=never ../instructions/a_president.md
echo "PANE 'a' (President) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はPresidentです。技術統括Boss Bとビジネス統括Boss Fを通じて、技術とビジネス両面から包括的な分析と戦略的意思決定を行います。"