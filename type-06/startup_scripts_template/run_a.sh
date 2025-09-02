#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数GEMINI_API_KEY_Aを設定 ★★★
clear
bat --paging=never ../instructions/a_president.md
echo "PANE 'a' (President) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はPresidentです。Boss Bを通じて階層的にWorker C、D、E、Fを統括し、包括的な分析と最終的な意思決定を行います。"