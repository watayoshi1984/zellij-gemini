#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set President-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_a.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🏛️  Starting Gemini Session for President (a)..."
echo "Role: Strategic Decision Maker & Dual-Boss Coordinator"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for President-a"
else
    echo "⚠️  Warning: GEMINI_API_KEY_A not set in load_env.sh"
fi

echo ""
echo "📋 Loading President instructions..."
cat "$(dirname "$0")/../instructions/a_president.md"

echo ""
echo "🎯 PRESIDENT USAGE GUIDE:"
echo ""
echo "1. 📊 DUAL-BOSS HIERARCHICAL LEADERSHIP:"
echo "   • Technical Group: Boss B → Workers C, D, E"
echo "   • Business Group: Boss F → Workers G, H"
echo ""
echo "2. 🔄 STRATEGIC TASK EXECUTION:"
echo "   Use: ./ask_tree.sh \"Your strategic question\""
echo "   • Automatically delegates to both Boss groups"
echo "   • Coordinates technical and business analysis"
echo "   • Integrates dual perspectives for decision-making"
echo ""
echo "3. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 1: Technical Boss (b)"
echo "   • Ctrl+b, q, 5: Business Boss (f)"
echo "   • Ctrl+b, q, 2-4: Technical Workers (c,d,e)"
echo "   • Ctrl+b, q, 6-7: Business Workers (g,h)"
echo ""
echo "4. 📈 STRATEGIC DECISION PROCESS:"
echo "   a) Issue strategic directive to both Boss groups"
echo "   b) Monitor technical feasibility analysis (Boss B)"
echo "   c) Monitor business viability analysis (Boss F)"
echo "   d) Integrate dual reports for final decision"
echo ""
echo "5. 🎪 COORDINATION COMMANDS:"
echo "   • Technical Focus: 'Analyze technical feasibility of...'"
echo "   • Business Focus: 'Evaluate market opportunity for...'"
echo "   • Integrated Analysis: 'Provide comprehensive analysis of...'"
echo ""
echo "💡 Remember: You coordinate TWO specialized groups for comprehensive analysis!"
echo "🚀 Ready for strategic leadership and dual-axis decision making!"
echo ""