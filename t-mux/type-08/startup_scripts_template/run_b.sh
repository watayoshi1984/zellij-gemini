#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Technical Boss-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_b.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🔧 Starting Gemini Session for Technical Boss (b)..."
echo "Role: Technical Group Leader & Implementation Coordinator"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Technical Boss-b"
else
    echo "⚠️  Warning: GEMINI_API_KEY_B not set in load_env.sh"
fi

echo ""
echo "📋 Loading Technical Boss instructions..."
cat "$(dirname "$0")/../instructions/b_boss.md"

echo ""
echo "🎯 TECHNICAL BOSS MANAGEMENT GUIDE:"
echo ""
echo "1. 👥 TECHNICAL WORKER COORDINATION:"
echo "   • System Design (c): Architecture & Tech Selection"
echo "   • Implementation (d): Development & Coding"
echo "   • Quality Assurance (e): Testing & Validation"
echo ""
echo "2. 📋 MANAGEMENT PROCESS:"
echo "   a) Receive strategic directive from President (a)"
echo "   b) Decompose into technical tasks"
echo "   c) Delegate to specialized workers"
echo "   d) Integrate technical reports"
echo "   e) Report feasibility to President"
echo ""
echo "3. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 0: Report to President (a)"
echo "   • Ctrl+b, q, 2: System Design Worker (c)"
echo "   • Ctrl+b, q, 3: Implementation Worker (d)"
echo "   • Ctrl+b, q, 4: Quality Assurance Worker (e)"
echo ""
echo "4. 🔄 TECHNICAL DELEGATION COMMANDS:"
echo "   To System Design (c): 'Design architecture for...'"
echo "   To Implementation (d): 'Estimate development effort for...'"
echo "   To Quality Assurance (e): 'Define testing strategy for...'"
echo ""
echo "5. 📊 INTEGRATION REPORT TEMPLATE:"
echo "   【技術統合報告】"
echo "   ■ 技術的実現可能性: [System Design analysis]"
echo "   ■ 実装複雑度・工数: [Implementation analysis]"
echo "   ■ 品質保証計画: [QA analysis]"
echo "   ■ 技術リスク評価: [Risk assessment]"
echo "   ■ 推奨技術案: [Technical recommendations]"
echo ""
echo "💡 Focus: Technical feasibility, implementation complexity, quality assurance!"
echo "🚀 Ready to lead the technical analysis team!"
echo ""