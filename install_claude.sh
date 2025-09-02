#!/bin/bash

# Claude Code CLIのインストールスクリプト

echo "Claude Code CLIのインストールを開始します..."

# Claude Code CLIのダウンロードとインストール
curl -fsSL https://downloads.anthropic.com/claude/code/latest/linux | sh

# インストール確認
if command -v claude &> /dev/null; then
    echo "Claude Code CLIのインストールが完了しました。"
else
    echo "Claude Code CLIのインストールに失敗しました。"
    exit 1
fi