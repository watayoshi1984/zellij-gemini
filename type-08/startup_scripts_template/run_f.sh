#!/bin/bash
export GEMINI_API_KEY="${GEMINI_API_KEY_F:-YOUR_API_KEY_FOR_F}" # ★★★ 環境変数GEMINI_API_KEY_Fを設定 ★★★
clear
/usr/local/bin/bat --paging=never ../instructions/f_boss.md
echo "PANE 'f' (Business Boss) IS READY. Starting Gemini AI..."
echo "======================================================"
gemini -p "私はBusiness Bossです。Worker G（市場分析）、H（事業戦略）を統括し、事業性と市場競争力を総合的に評価してPresidentに報告します。"