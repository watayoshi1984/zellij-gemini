#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Quality Assurance Worker-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_e.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🔍 Starting Gemini Session for Quality Assurance Worker (e)..."
echo "Role: Quality Assurance & Testing Specialist"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Quality Assurance Worker-e"
else
    echo "⚠️  Warning: GEMINI_API_KEY_E not set in load_env.sh"
fi

echo ""
echo "📋 Loading Quality Assurance Worker instructions..."
cat "$(dirname "$0")/../instructions/e_worker.md"

echo ""
echo "🎯 QUALITY ASSURANCE FOCUS AREAS:"
echo ""
echo "1. 🧪 TESTING STRATEGY:"
echo "   • Comprehensive test planning and design"
echo "   • Test automation strategy and implementation"
echo "   • Performance and load testing approaches"
echo "   • Security and vulnerability testing"
echo ""
echo "2. 📊 QUALITY METRICS:"
echo "   • Quality standards and acceptance criteria"
echo "   • Test coverage and effectiveness metrics"
echo "   • Defect tracking and quality gates"
echo "   • Continuous quality monitoring"
echo ""
echo "3. 🔧 QUALITY DELIVERABLES:"
echo "   • Test strategy and planning documents"
echo "   • Test case design and automation scripts"
echo "   • Quality assurance processes and procedures"
echo "   • Quality reports and recommendations"
echo ""
echo "4. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 1: Report to Technical Boss (b)"
echo "   • Ctrl+b, q, 2: Coordinate with System Design (c)"
echo "   • Ctrl+b, q, 3: Collaborate with Implementation (d)"
echo ""
echo "5. 🔄 COLLABORATION WORKFLOW:"
echo "   a) Receive quality requirements from Boss B"
echo "   b) Review system design for testability (Worker C)"
echo "   c) Plan testing approach with implementation team (Worker D)"
echo "   d) Design comprehensive testing strategy"
echo "   e) Report quality analysis to Technical Boss (b)"
echo ""
echo "6. 📈 ANALYSIS PRIORITIES:"
echo "   • Testability assessment of system design"
echo "   • Quality risk identification and mitigation"
echo "   • Test automation feasibility and ROI"
echo "   • Quality assurance process optimization"
echo ""
echo "7. 🛡️  QUALITY DIMENSIONS:"
echo "   • Functional Quality: Feature correctness and completeness"
echo "   • Non-functional Quality: Performance, security, usability"
echo "   • Process Quality: Development and deployment processes"
echo "   • User Quality: User experience and satisfaction"
echo ""
echo "8. 🔬 TESTING APPROACHES:"
echo "   • Unit Testing: Component-level verification"
echo "   • Integration Testing: System interaction validation"
echo "   • System Testing: End-to-end functionality"
echo "   • Acceptance Testing: Business requirement validation"
echo ""
echo "💡 Remember: Quality is built in, not tested in - influence design and implementation!"
echo "🚀 Ready to ensure exceptional quality and reliability!"
echo ""