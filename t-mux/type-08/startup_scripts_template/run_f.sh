#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Business Boss-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_f.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "💼 Starting Gemini Session for Business Boss (f)..."
echo "Role: Business Group Leader & Strategic Coordinator"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Business Boss-f"
else
    echo "⚠️  Warning: GEMINI_API_KEY_F not set in load_env.sh"
fi

echo ""
echo "📋 Loading Business Boss instructions..."
cat "$(dirname "$0")/../instructions/f_boss.md"

echo ""
echo "🎯 BUSINESS BOSS MANAGEMENT GUIDE:"
echo ""
echo "1. 👥 BUSINESS WORKER COORDINATION:"
echo "   • Market Analysis (g): Market Research & Competitive Intelligence"
echo "   • Business Strategy (h): Business Model & Financial Planning"
echo ""
echo "2. 📋 MANAGEMENT PROCESS:"
echo "   a) Receive strategic directive from President (a)"
echo "   b) Decompose into business analysis tasks"
echo "   c) Delegate to specialized workers"
echo "   d) Integrate business reports"
echo "   e) Report business viability to President"
echo ""
echo "3. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 0: Report to President (a)"
echo "   • Ctrl+b, q, 6: Market Analysis Worker (g)"
echo "   • Ctrl+b, q, 7: Business Strategy Worker (h)"
echo ""
echo "4. 🔄 BUSINESS DELEGATION COMMANDS:"
echo "   To Market Analysis (g): 'Analyze market opportunity for...'"
echo "   To Business Strategy (h): 'Develop business model for...'"
echo ""
echo "5. 📊 INTEGRATION REPORT TEMPLATE:"
echo "   【ビジネス統合報告】"
echo "   ■ 市場機会評価: [Market Analysis findings]"
echo "   ■ 事業性評価: [Business Strategy analysis]"
echo "   ■ ビジネスリスク評価: [Risk assessment]"
echo "   ■ 戦略推奨案: [Strategic recommendations]"
echo "   ■ 投資・ROI予測: [Financial projections]"
echo ""
echo "6. 💡 STRATEGIC COORDINATION:"
echo "   • Market-Strategy Alignment: Ensure strategy matches market reality"
echo "   • Risk-Opportunity Balance: Weigh potential vs challenges"
echo "   • Financial Viability: Validate sustainable business model"
echo "   • Competitive Positioning: Define unique value proposition"
echo ""
echo "7. 📈 BUSINESS SUCCESS METRICS:"
echo "   • Market Fit: Product-market alignment strength"
echo "   • Revenue Potential: Sustainable income generation"
echo "   • Growth Scalability: Expansion and scaling capability"
echo "   • Competitive Advantage: Differentiation sustainability"
echo ""
echo "💡 Focus: Market viability, business model sustainability, strategic positioning!"
echo "🚀 Ready to lead the business analysis team!"
echo ""