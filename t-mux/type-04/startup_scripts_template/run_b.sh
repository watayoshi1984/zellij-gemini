#!/bin/bash
# run_b.sh - Worker B (b) 起動スクリプト

# 共通環境設定を読み込む
source ../../common/load_env.sh

# Worker B用APIキーを設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_b.sh ファイルを編集してAPIキーを設定してください。"
fi

# Geminiセッションを開始
echo "Starting Gemini session for Worker B (Technical Analysis)..."
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

clear

# 指示書を表示（batが利用可能な場合）
if command -v bat &> /dev/null; then
    /usr/local/bin/bat --paging=always ../instructions/b_worker.md
else
    echo "=== Worker B Instructions ==="
    cat ../instructions/b_worker.md
    echo "============================="
fi

echo ""
echo "PANE 'b' (Worker B - Technical Analysis) IS READY."
echo "役割: 技術的側面の分析担当"
echo "(Press 'q' to exit viewer if using bat)"
echo ""

# シェルを起動
exec $SHELL