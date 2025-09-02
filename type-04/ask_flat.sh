#!/bin/bash
# 使い方: ./ask_flat.sh "実行させたい質問"
if [ "$#" -ne 1 ]; then echo "使い方: $0 \"<質問>\""; exit 1; fi
QUESTION="$1"

echo "====================================================================="
echo "PRESIDENT: 受け取った質問「$QUESTION」をタスク分解して各Workerに割り当てます"
echo "====================================================================="

# Presidentがタスク分解を行う
TASK_DECOMPOSITION_PROMPT="以下の質問「$QUESTION」について、3つの異なる視点から分析するためのタスクを作成してください。
Worker B用タスク: 技術的な側面や仕組みについて
Worker C用タスク: 現在の動向や最新情報について  
Worker D用タスク: 将来展望や影響について
各タスクを「Worker B: [具体的なタスク]」の形式で1行ずつ出力してください。"

echo "PRESIDENT: タスク分解中..."
gemini -p "$TASK_DECOMPOSITION_PROMPT"

echo ""
echo "PRESIDENT: 各Workerにタスクを割り当てます..."

# 現在のZellijバージョンに対応したペイン間通信関数
focus_pane_and_execute() {
    local target_pane="$1"
    local cmd_to_run="$2"
    
    echo ">>> Worker $target_pane で実行中: $cmd_to_run"
    
    # レイアウトに基づく正しいペインフォーカス移動
    case "$target_pane" in
        "b")
            zellij action move-focus down
            ;;
        "c") 
            zellij action move-focus down
            zellij action move-focus right  # bを経由してcへ
            ;;
        "d")
            zellij action move-focus down
            zellij action move-focus down  # 最下段のdペインへ
            ;;
    esac
    
    # コマンドを実行
    zellij action write-chars "$cmd_to_run"
    
    # Enterキーを押してコマンド実行
    zellij action write 13  # ASCII 13 = Enter
    
    # 元のペイン（President）に戻る
    case "$target_pane" in
        "b")
            zellij action move-focus up
            ;;
        "c") 
            zellij action move-focus left
            zellij action move-focus up
            ;;
        "d")
            zellij action move-focus up
            zellij action move-focus up
            ;;
    esac
    
    sleep 2  # 実行結果を待つ
}

# 各Workerに具体的なタスクを割り当て
echo "================================================="
echo ">>> WORKER B への技術的分析タスク割り当て..."
echo "================================================="
TASK_B="「$QUESTION」について、技術的な仕組みや実装方法の観点から分析してください。技術的詳細に焦点を当てて簡潔に回答し、完了後にPresidentに報告してください。"
focus_pane_and_execute "b" "gemini -p '$TASK_B'"

echo ""
echo "================================================="
echo ">>> WORKER C への現状動向分析タスク割り当て..."
echo "================================================="
TASK_C="「$QUESTION」について、現在の動向や最新情報の観点から分析してください。市場動向や最新トレンドに焦点を当てて簡潔に回答し、完了後にPresidentに報告してください。"
focus_pane_and_execute "c" "gemini -p '$TASK_C'"

echo ""
echo "================================================="
echo ">>> WORKER D への将来展望分析タスク割り当て..."
echo "================================================="
TASK_D="「$QUESTION」について、将来展望や社会への影響の観点から分析してください。未来予測や影響分析に焦点を当てて簡潔に回答し、完了後にPresidentに報告してください。"
focus_pane_and_execute "d" "gemini -p '$TASK_D'"

echo ""
echo "====================================================================="
echo "PRESIDENT: 全てのタスクを各Workerに割り当てました。報告を待機します。"
echo "====================================================================="