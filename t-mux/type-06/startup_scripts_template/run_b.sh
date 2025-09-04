#!/bin/bash
# run_b.sh - Boss (b) startup script for type-06
# 中間管理層：Worker統括・報告統合

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# Boss専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_b.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "👔 Starting Boss (b) - Middle Management & Worker Coordination"
echo "======================================================"
echo "Role: Worker Management & Report Integration"
echo "Reports to: President (a)"
echo "Manages: Workers (c,d,e,f)"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for Boss..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 Boss Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/b_boss.md"
else
    cat "instructions/b_boss.md"
fi

echo ""
echo "🚀 Management Process:"
echo "1. Receive instructions from President (a)"
echo "2. Decompose tasks for specialized Workers"
echo "3. Coordinate Worker C (Tech), D (Market), E (Strategy), F (Risk)"
echo "4. Monitor progress and ensure quality"
echo "5. Integrate reports and present to President"
echo ""
echo "👥 Worker Coordination:"
echo "- Worker C (Tech): Down Arrow → Left (Technical analysis)"
echo "- Worker D (Market): Down Arrow → Right (Market analysis)"
echo "- Worker E (Strategy): Down Arrow × 2 → Left (Strategic analysis)"
echo "- Worker F (Risk): Down Arrow × 2 → Right (Risk analysis)"
echo ""
echo "📱 Tmux Navigation:"
echo "- Return to President: Ctrl+b + Left Arrow"
echo "- Access Workers: Ctrl+b + Down Arrow"
echo "- Switch between Workers: Ctrl+b + Left/Right Arrow"
echo ""
echo "📊 Report Integration Template:"
echo "=== INTEGRATED ANALYSIS REPORT ==="
echo "■ Executive Summary: [Key findings]"
echo "■ Technical Analysis (Worker C): [Summary]"
echo "■ Market Analysis (Worker D): [Summary]"
echo "■ Strategic Analysis (Worker E): [Summary]"
echo "■ Risk Analysis (Worker F): [Summary]"
echo "■ Recommendations: [Integrated recommendations]"
echo "■ Next Steps: [Action items]"
echo ""
echo "✅ Boss (b) environment ready for worker coordination and management!"
echo ""