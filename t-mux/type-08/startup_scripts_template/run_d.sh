#!/bin/bash

# Load common environment settings
source "$(dirname "$0")/../../load_env.sh"

# Set Implementation Worker-specific API key（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_d.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "💻 Starting Gemini Session for Implementation Worker (d)..."
echo "Role: Development & Implementation Specialist"
echo ""

# Start Gemini session
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✅ API Key configured for Implementation Worker-d"
else
    echo "⚠️  Warning: GEMINI_API_KEY_D not set in load_env.sh"
fi

echo ""
echo "📋 Loading Implementation Worker instructions..."
cat "$(dirname "$0")/../instructions/d_worker.md"

echo ""
echo "🎯 IMPLEMENTATION FOCUS AREAS:"
echo ""
echo "1. 🚀 DEVELOPMENT PLANNING:"
echo "   • Implementation approach and methodology"
echo "   • Development timeline and milestone planning"
echo "   • Resource allocation and team structure"
echo "   • Risk assessment and mitigation strategies"
echo ""
echo "2. 🔨 TECHNICAL IMPLEMENTATION:"
echo "   • Code architecture and design patterns"
echo "   • Development tools and framework selection"
echo "   • Performance optimization strategies"
echo "   • Security implementation practices"
echo ""
echo "3. 📊 DEVELOPMENT DELIVERABLES:"
echo "   • Implementation roadmap and schedules"
echo "   • Development effort estimates"
echo "   • Technical implementation guidelines"
echo "   • Code quality and review processes"
echo ""
echo "4. 🎛️  TMUX NAVIGATION:"
echo "   • Ctrl+b, q, 1: Report to Technical Boss (b)"
echo "   • Ctrl+b, q, 2: Coordinate with System Design (c)"
echo "   • Ctrl+b, q, 4: Collaborate with Quality Assurance (e)"
echo ""
echo "5. 🔄 COLLABORATION WORKFLOW:"
echo "   a) Receive implementation requirements from Boss B"
echo "   b) Review system design specifications from Worker C"
echo "   c) Plan development approach and estimate effort"
echo "   d) Coordinate testing requirements with Worker E"
echo "   e) Report implementation analysis to Technical Boss (b)"
echo ""
echo "6. 📈 ANALYSIS PRIORITIES:"
echo "   • Implementation complexity assessment"
echo "   • Development effort and timeline estimation"
echo "   • Technical risk identification"
echo "   • Code quality and maintainability planning"
echo ""
echo "7. 🛠️  DEVELOPMENT CONSIDERATIONS:"
echo "   • Scalable and maintainable code structure"
echo "   • Efficient development processes and CI/CD"
echo "   • Performance optimization from the start"
echo "   • Security best practices integration"
echo ""
echo "💡 Remember: Your implementation plan determines project success and timeline!"
echo "🚀 Ready to build robust and efficient solutions!"
echo ""