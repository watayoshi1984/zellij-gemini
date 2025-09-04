#!/bin/bash
# ask_tree.sh - type-06 tmux版階層的タスク実行スクリプト
# 使い方: ./ask_tree.sh "実行させたい質問"

if [ "$#" -ne 1 ]; then 
    echo "使い方: $0 \"<質問>\""
    echo "例: ./ask_tree.sh \"AIを活用したヘルスケアサービスの事業計画を分析してください\""
    exit 1
fi

QUESTION="$1"
SESSION_NAME="gemini-squad-6"

# 共通設定を読み込み
source "../common/load_env.sh"

echo "====================================================================="
echo "PRESIDENT: 受け取った質問「$QUESTION」を階層的にタスク分解してBossに指示します"
echo "====================================================================="

# tmuxセッションが存在するかチェック
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Error: tmux session '$SESSION_NAME' not found."
    echo "Please run './tmux_layout.sh' first to create the session."
    exit 1
fi

# Presidentがタスク分解を行う
TASK_DECOMPOSITION_PROMPT="以下の質問「$QUESTION」について、階層的な分析を行うためのタスクを作成してください。
Boss B: 各Workerの統括と技術・市場・戦略・リスク視点の統合
Worker C: 技術的な側面や仕組みについて詳細分析
Worker D: 市場動向や競合状況について詳細分析  
Worker E: 戦略的将来展望や事業戦略について詳細分析
Worker F: リスク評価や課題分析について詳細分析

Boss Bが各Workerを統括し、Presidentに統合報告を行う構造で進めてください。"

echo "PRESIDENT: 階層的タスク分解中..."
gemini -p "$TASK_DECOMPOSITION_PROMPT"

echo ""
echo "PRESIDENT: Boss Bに指示を出します..."

# Boss Bに統括指示を出す
echo "================================================="
echo ">>> BOSS B への統括指示..."
echo "================================================="
BOSS_TASK="「$QUESTION」について、以下の各Workerから専門分野の分析を依頼し、統合報告をPresidentに提出してください。

Worker C担当: 技術的な側面や仕組みの詳細分析
Worker D担当: 市場動向や競合状況の詳細分析  
Worker E担当: 戦略的将来展望や事業戦略の詳細分析
Worker F担当: リスク評価や課題分析の詳細分析

各Workerの分析結果を統合し、包括的な結論をPresidentに報告してください。"

# tmux版のペイン間通信を使用
focus_pane_and_execute_tmux "$SESSION_NAME" "Boss-b" "gemini -p '$BOSS_TASK'"

echo ""
echo "====================================================================="
echo "PRESIDENT: Boss Bに統括指示を出しました。Boss主導での階層実行を待機します。"
echo "====================================================================="
echo ""
echo "📋 実行状況:"
echo "1. ✅ President: タスク分解完了"
echo "2. ✅ Boss-b: 統括指示送信完了"
echo "3. ⏳ Boss-b: Worker統括・分析実行中..."
echo "4. ⏳ Workers: 専門分野分析実行中..."
echo "5. ⏳ Boss-b: 統合報告作成中..."
echo "6. ⏳ President: 最終意思決定待機中..."
echo ""
echo "📱 Tmux操作:"
echo "- Boss-bペインを確認: Ctrl+b + Right Arrow"
echo "- Workerペインを確認: Ctrl+b + Down Arrow (from Boss-b)"
echo "- Presidentペインに戻る: Ctrl+b + Left Arrow"
echo ""
echo "⏰ 処理時間の目安: 5-10分程度"
echo "💡 各ペインの進捗状況を定期的に確認してください。"
echo ""