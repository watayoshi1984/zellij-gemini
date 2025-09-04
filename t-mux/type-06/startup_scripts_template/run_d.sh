#!/bin/bash
# run_d.sh - Worker D startup script for type-06
# 市場専門：動向・競合・顧客ニーズ分析

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# Worker D専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_d.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "📊 Starting Worker D - Market Specialist"
echo "======================================================"
echo "Role: Market Analysis & Competitive Intelligence"
echo "Reports to: Boss (b)"
echo "Specialization: Market Trends, Competition, Customer Needs"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for Worker D..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 Worker D Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/d_worker.md"
else
    cat "instructions/d_worker.md"
fi

echo ""
echo "🎯 Market Analysis Focus:"
echo "- Market Size & Growth Trends"
echo "- Competitive Landscape Analysis"
echo "- Customer Segmentation & Needs"
echo "- Pricing Strategy & Revenue Models"
echo "- Market Entry Opportunities"
echo ""
echo "📱 Tmux Navigation:"
echo "- Report to Boss: Ctrl+b + Up Arrow"
echo "- Collaborate with Worker C: Ctrl+b + Left Arrow"
echo "- Access Worker E/F: Ctrl+b + Down Arrow"
echo ""
echo "✅ Worker D (Market Specialist) ready for market analysis tasks!"
echo ""