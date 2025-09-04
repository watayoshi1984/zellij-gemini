#!/bin/bash
# run_a.sh - President (a) startup script for type-06
# 階層構造の最上位：全体統括・最終意思決定

# 共通環境設定を読み込み
source "../../common/load_env.sh"

# President専用のAPI設定（ハードコード）
# ★★★ 以下にあなたのAPIキーを直接記入してください ★★★
export GEMINI_API_KEY="YOUR_GEMINI_API_KEY_HERE"  # Gemini APIキーをここに記入
export CLAUDE_API_KEY="YOUR_CLAUDE_API_KEY_HERE"  # Claude APIキーをここに記入

# APIキーが設定されているかチェック
if [[ "$GEMINI_API_KEY" == "YOUR_GEMINI_API_KEY_HERE" ]] && [[ "$CLAUDE_API_KEY" == "YOUR_CLAUDE_API_KEY_HERE" ]]; then
    echo "⚠️  WARNING: APIキーが設定されていません！"
    echo "   run_a.sh ファイルを編集してAPIキーを設定してください。"
fi

echo "🏛️  Starting President (a) - Hierarchical Leadership Environment"
echo "======================================================"
echo "Role: Overall Project Leadership & Final Decision Making"
echo "Structure: President(a) -> Boss(b) -> Workers(c,d,e,f)"
echo "======================================================"
echo ""

# Geminiセッションを開始
echo "🤖 Initializing Gemini session for President..."
if command -v gemini &> /dev/null; then
    gemini
else
    echo "⚠️  Gemini CLI not found. Please install gemini CLI tool."
    echo "📝 Alternative: Use direct API calls or web interface"
fi

echo ""
echo "📋 President Instructions:"
echo ""

# 指示書を表示（batが利用可能な場合は色付きで表示）
if command -v bat &> /dev/null; then
    bat --style=numbers,header --language=markdown "instructions/a_president.md"
else
    cat "instructions/a_president.md"
fi

echo ""
echo "🚀 Usage Instructions:"
echo "1. Define project requirements and objectives"
echo "2. Use: ./ask_tree.sh \"project description\" to start hierarchical execution"
echo "3. Monitor Boss-b coordination and Worker execution"
echo "4. Review integrated reports from Boss-b"
echo "5. Make final decisions based on comprehensive analysis"
echo ""
echo "🎯 Hierarchy Management:"
echo "- Boss-b coordinates all Workers (c,d,e,f)"
echo "- Workers provide specialized analysis"
echo "- Boss-b integrates and reports to President"
echo "- President makes final strategic decisions"
echo ""
echo "📱 Tmux Navigation:"
echo "- Switch to Boss-b: Ctrl+b + Right Arrow"
echo "- Monitor Workers: Ctrl+b + Down Arrow (from Boss-b)"
echo "- Return to President: Ctrl+b + Left Arrow"
echo ""
echo "✅ President (a) environment ready for hierarchical project leadership!"
echo ""