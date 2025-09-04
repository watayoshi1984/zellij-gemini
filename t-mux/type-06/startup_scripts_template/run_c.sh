#!/bin/bash
# run_c.sh - Worker C startup script for type-06
# 技術専門：実装・アーキテクチャ・性能分析

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# Worker C専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_c.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🔧 Starting Worker C - Technical Specialist"
echo "======================================================"
echo "Role: Technical Implementation & Architecture Analysis"
echo "Reports to: Boss (b)"
echo "Specialization: Tech Stack, Performance, Security"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for Worker C..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 Worker C Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/c_worker.md"
else
    cat "instructions/c_worker.md"
fi

echo ""
echo "🎯 Technical Analysis Focus:"
echo "- System Architecture & Design Patterns"
echo "- Technology Stack Evaluation"
echo "- Performance & Scalability Analysis"
echo "- Security & Compliance Requirements"
echo "- Implementation Feasibility Assessment"
echo ""
echo "📱 Tmux Navigation:"
echo "- Report to Boss: Ctrl+b + Up Arrow"
echo "- Collaborate with Worker D: Ctrl+b + Right Arrow"
echo "- Access Worker E/F: Ctrl+b + Down Arrow"
echo ""
echo "✅ Worker C (Technical Specialist) ready for technical analysis tasks!"
echo ""