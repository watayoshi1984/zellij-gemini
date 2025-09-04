#!/bin/bash
# run_e.sh - Worker E startup script for type-06
# 戦略専門：将来展望・事業戦略・成長計画

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# Worker E専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_e.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🎯 Starting Worker E - Strategy Specialist"
echo "======================================================"
echo "Role: Strategic Planning & Future Vision"
echo "Reports to: Boss (b)"
echo "Specialization: Business Strategy, Growth Planning"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for Worker E..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 Worker E Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/e_worker.md"
else
    cat "instructions/e_worker.md"
fi

echo ""
echo "🎯 Strategic Analysis Focus:"
echo "- Long-term Business Strategy (3-5 years)"
echo "- Future Market & Technology Trends"
echo "- Growth Opportunities & Expansion Plans"
echo "- Competitive Positioning Strategy"
echo "- Strategic Decision Support"
echo ""
echo "📱 Tmux Navigation:"
echo "- Report to Boss: Ctrl+b + Up Arrow × 2"
echo "- Collaborate with Worker F: Ctrl+b + Right Arrow"
echo "- Access Worker C/D: Ctrl+b + Up Arrow"
echo ""
echo "✅ Worker E (Strategy Specialist) ready for strategic analysis tasks!"
echo ""