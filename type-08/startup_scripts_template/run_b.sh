#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_B:-YOUR_API_KEY_FOR_B}" # ★★★ 環境変数GEMINI_API_KEY_Bを設定 ★★★
clear
/usr/local/bin/bat --paging=never ../instructions/b_boss.md
echo "PANE 'b' (Technical Boss) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はTechnical Bossです。Worker C（設計）、D（実装）、E（品質）を統括し、技術的実現可能性を総合的に評価してPresidentに報告します。"