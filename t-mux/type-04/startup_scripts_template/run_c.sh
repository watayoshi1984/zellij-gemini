#!/bin/bash
# run_c.sh - Worker C (c) 起動スクリプト

# 共通環境設定を読み込む
source ../../common/load_env.sh

# Worker C用APIキーを設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_c.sh ファイルを編集してAPIキーを設定してください。"
fi

# Geminiセッションを開始
echo "Starting Gemini session for Worker C (Current Trends Analysis)..."
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

clear

# 指示書を表示（batが利用可能な場合）
if command -v bat &> /dev/null; then
    /usr/local/bin/bat --paging=always ../instructions/c_worker.md
else
    echo "=== Worker C Instructions ==="
    cat ../instructions/c_worker.md
    echo "============================="
fi

echo ""
echo "PANE 'c' (Worker C - Current Trends Analysis) IS READY."
echo "役割: 現状動向の分析担当"
echo "(Press 'q' to exit viewer if using bat)"
echo ""

# シェルを起動
exec $SHELL