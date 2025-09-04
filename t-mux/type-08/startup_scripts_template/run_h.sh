#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Business Strategy Worker-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_h.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🎯 Starting Gemini Session for Business Strategy Worker (h)..."
echo "Role: Business Model & Financial Strategy Specialist"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Business Strategy Worker-h"
else
    echo "⚠️  Warning: GEMINI_API_KEY_H not set in load_env.sh"
fi

echo ""
echo "📋 Loading Business Strategy Worker instructions..."
cat "$(dirname "$0")/../instructions/h_worker.md"

echo ""
echo "🎯 BUSINESS STRATEGY FOCUS AREAS:"
echo ""
echo "1. 💰 BUSINESS MODEL DESIGN:"
echo "   • Value proposition and customer value creation"
echo "   • Revenue streams and monetization strategies"
echo "   • Cost structure and operational efficiency"
echo "   • Strategic partnerships and ecosystem design"
echo ""
echo "2. 📊 FINANCIAL PLANNING:"
echo "   • Revenue forecasting and financial modeling"
echo "   • Investment requirements and funding strategy"
echo "   • Profitability analysis and break-even planning"
echo "   • Cash flow management and financial sustainability"
echo ""
echo "3. 🚀 GROWTH STRATEGY:"
echo "   • Market expansion and scaling strategies"
echo "   • Product development and innovation roadmap"
echo "   • Customer acquisition and retention strategies"
echo "   • Operational scaling and efficiency optimization"
echo ""
echo "4. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 5: Report to Business Boss (f)"
echo "   • Ctrl+b, q, 6: Collaborate with Market Analysis (g)"
echo ""
echo "5. 🔄 COLLABORATION WORKFLOW:"
echo "   a) Receive strategic requirements from Boss F"
echo "   b) Incorporate market insights from Worker G"
echo "   c) Develop comprehensive business strategy"
echo "   d) Validate strategy with market data and assumptions"
echo "   e) Report business strategy to Business Boss (f)"
echo ""
echo "6. 📈 STRATEGIC FRAMEWORKS:"
echo "   • Business Model Canvas: Comprehensive model design"
echo "   • Financial Modeling: DCF, NPV, IRR analysis"
echo "   • Strategic Planning: Vision, mission, objectives"
echo "   • Risk Assessment: Business and financial risks"
echo ""
echo "7. 💡 KEY STRATEGY COMPONENTS:"
echo "   • Value Creation: How we create and deliver value"
echo "   • Competitive Advantage: Sustainable differentiation"
echo "   • Growth Engine: Scalable business drivers"
echo "   • Financial Sustainability: Long-term viability"
echo ""
echo "8. 📋 DELIVERABLE PRIORITIES:"
echo "   • Business model design and validation"
echo "   • Financial projections and investment analysis"
echo "   • Growth strategy and scaling roadmap"
echo "   • Risk assessment and mitigation strategies"
echo ""
echo "9. 🔍 ANALYSIS DIMENSIONS:"
echo "   • Market Fit: Strategy alignment with market reality"
echo "   • Financial Viability: Sustainable profitability model"
echo "   • Execution Feasibility: Realistic implementation plan"
echo "   • Competitive Positioning: Unique market position"
echo ""
echo "💡 Remember: Your strategy transforms market opportunities into business success!"
echo "🚀 Ready to design winning business models and growth strategies!"
echo ""