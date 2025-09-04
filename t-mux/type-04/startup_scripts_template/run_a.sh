#!/bin/bash
# run_a.sh - President (a) 起動スクリプト

# 共通環境設定を読み込む
source ../../common/load_env.sh

# President用APIキーを設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_a.sh ファイルを編集してAPIキーを設定してください。"
fi

# Geminiセッションを開始
echo "Starting Gemini session for President..."
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."

clear

# 指示書を表示（batが利用可能な場合）
if command -v bat &> /dev/null; then
    /usr/local/bin/bat --paging=always ../instructions/a_president.md
else
    echo "=== President Instructions ==="
    cat ../instructions/a_president.md
    echo "============================="
fi

echo ""
echo "PANE 'a' (President) IS READY."
echo "使用方法: ./ask_flat.sh \"質問内容\" でタスクを開始"
echo "(Press 'q' to exit viewer if using bat)"
echo ""

# シェルを起動
exec $SHELL