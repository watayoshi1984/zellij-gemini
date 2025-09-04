#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Market Analysis Worker-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_g.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "📊 Starting Gemini Session for Market Analysis Worker (g)..."
echo "Role: Market Research & Competitive Intelligence Specialist"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Market Analysis Worker-g"
else
    echo "⚠️  Warning: GEMINI_API_KEY_G not set in load_env.sh"
fi

echo ""
echo "📋 Loading Market Analysis Worker instructions..."
cat "$(dirname "$0")/../instructions/g_worker.md"

echo ""
echo "🎯 MARKET ANALYSIS FOCUS AREAS:"
echo ""
echo "1. 📈 MARKET OPPORTUNITY:"
echo "   • Total Addressable Market (TAM) analysis"
echo "   • Serviceable Addressable Market (SAM) evaluation"
echo "   • Serviceable Obtainable Market (SOM) estimation"
echo "   • Market growth trends and future projections"
echo ""
echo "2. 🏢 COMPETITIVE LANDSCAPE:"
echo "   • Direct and indirect competitor identification"
echo "   • Competitive positioning and differentiation"
echo "   • Market share analysis and dynamics"
echo "   • Competitive strengths and weaknesses"
echo ""
echo "3. 👥 CUSTOMER INSIGHTS:"
echo "   • Target customer segmentation and personas"
echo "   • Customer needs and pain point analysis"
echo "   • Buying behavior and decision processes"
echo "   • Price sensitivity and willingness to pay"
echo ""
echo "4. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 5: Report to Business Boss (f)"
echo "   • Ctrl+b, q, 7: Collaborate with Business Strategy (h)"
echo ""
echo "5. 🔄 COLLABORATION WORKFLOW:"
echo "   a) Receive market research requirements from Boss F"
echo "   b) Conduct comprehensive market analysis"
echo "   c) Share market insights with Business Strategy (h)"
echo "   d) Validate strategy assumptions with market data"
echo "   e) Report market analysis to Business Boss (f)"
echo ""
echo "6. 📊 ANALYSIS METHODOLOGIES:"
echo "   • Primary Research: Surveys, interviews, focus groups"
echo "   • Secondary Research: Industry reports, public data"
echo "   • Competitive Intelligence: Competitor analysis"
echo "   • Trend Analysis: Market and technology trends"
echo ""
echo "7. 🔍 KEY RESEARCH AREAS:"
echo "   • Market Size & Growth: Quantitative market assessment"
echo "   • Customer Behavior: Qualitative insights and patterns"
echo "   • Competitive Dynamics: Strategic positioning analysis"
echo "   • Market Entry: Barriers, opportunities, timing"
echo ""
echo "8. 📋 DELIVERABLE PRIORITIES:"
echo "   • Market opportunity assessment and sizing"
echo "   • Competitive landscape mapping and analysis"
echo "   • Customer persona development and validation"
echo "   • Market entry strategy recommendations"
echo ""
echo "💡 Remember: Your market insights drive strategic business decisions!"
echo "🚀 Ready to uncover market opportunities and competitive advantages!"
echo ""