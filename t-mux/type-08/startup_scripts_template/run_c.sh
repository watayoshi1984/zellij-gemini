#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set System Design Worker-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_c.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🏗️  Starting Gemini Session for System Design Worker (c)..."
echo "Role: System Architecture & Technical Design Specialist"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for System Design Worker-c"
else
    echo "⚠️  Warning: GEMINI_API_KEY_C not set in load_env.sh"
fi

echo ""
echo "📋 Loading System Design Worker instructions..."
cat "$(dirname "$0")/../instructions/c_worker.md"

echo ""
echo "🎯 SYSTEM DESIGN FOCUS AREAS:"
echo ""
echo "1. 🏛️  ARCHITECTURE DESIGN:"
echo "   • System structure and component design"
echo "   • Technology stack selection"
echo "   • Scalability and performance architecture"
echo "   • Security architecture planning"
echo ""
echo "2. 🔧 TECHNICAL SPECIFICATIONS:"
echo "   • Database design and data modeling"
echo "   • API design and integration patterns"
echo "   • Infrastructure and deployment architecture"
echo "   • Microservices vs monolithic decisions"
echo ""
echo "3. 📊 DESIGN DELIVERABLES:"
echo "   • System architecture diagrams"
echo "   • Technical specification documents"
echo "   • Technology selection rationale"
echo "   • Implementation constraints and guidelines"
echo ""
echo "4. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 1: Report to Technical Boss (b)"
echo "   • Ctrl+b, q, 3: Collaborate with Implementation (d)"
echo "   • Ctrl+b, q, 4: Coordinate with Quality Assurance (e)"
echo ""
echo "5. 🔄 COLLABORATION WORKFLOW:"
echo "   a) Receive architecture requirements from Boss B"
echo "   b) Design system architecture and select technologies"
echo "   c) Share design specifications with Implementation (d)"
echo "   d) Provide testing architecture to Quality Assurance (e)"
echo "   e) Report design analysis to Technical Boss (b)"
echo ""
echo "6. 📈 ANALYSIS PRIORITIES:"
echo "   • Technical feasibility assessment"
echo "   • Architecture scalability evaluation"
echo "   • Technology stack optimization"
echo "   • Future extensibility planning"
echo ""
echo "💡 Remember: Your design decisions impact the entire technical implementation!"
echo "🚀 Ready to architect robust and scalable systems!"
echo ""