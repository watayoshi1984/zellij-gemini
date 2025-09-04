#!/bin/bash
# run_f.sh - Worker F startup script for type-06
# リスク専門：課題・リスク・対策案分析

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# Worker F専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_f.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "⚠️  Starting Worker F - Risk Specialist"
echo "======================================================"
echo "Role: Risk Analysis & Issue Management"
echo "Reports to: Boss (b)"
echo "Specialization: Risk Assessment, Problem Solving"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for Worker F..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 Worker F Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/f_worker.md"
else
    cat "instructions/f_worker.md"
fi

echo ""
echo "🎯 Risk Analysis Focus:"
echo "- Business & Operational Risk Assessment"
echo "- Technical & Implementation Risks"
echo "- Market & Competitive Risks"
echo "- Legal & Compliance Requirements"
echo "- Risk Mitigation & Contingency Planning"
echo ""
echo "📱 Tmux Navigation:"
echo "- Report to Boss: Ctrl+b + Up Arrow × 2"
echo "- Collaborate with Worker E: Ctrl+b + Left Arrow"
echo "- Access Worker C/D: Ctrl+b + Up Arrow"
echo ""
echo "✅ Worker F (Risk Specialist) ready for risk analysis tasks!"
echo ""