#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_B:-YOUR_API_KEY_FOR_B}" # ★★★ 環境変数GEMINI_API_KEY_Bを設定 ★★★
clear
bat --paging=never ../instructions/b_boss.md
echo "PANE 'b' (Boss) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はBossです。President Aからタスクを受け取り、Worker C、D、E、Fにタスクを分配します。"