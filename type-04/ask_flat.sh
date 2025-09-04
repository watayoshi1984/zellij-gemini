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
# Geminiからの出力を変数に保存
DECOMPOSED_TASKS=$(gemini -p "$TASK_DECOMPOSITION_PROMPT")
echo "$DECOMPOSED_TASKS"

# 各Workerのタスクを抽出
TASK_B=$(echo "$DECOMPOSED_TASKS" | grep "Worker B:" | sed 's/Worker B: //')
TASK_C=$(echo "$DECOMPOSED_TASKS" | grep "Worker C:" | sed 's/Worker C: //')
TASK_D=$(echo "$DECOMPOSED_TASKS" | grep "Worker D:" | sed 's/Worker D: //')

echo ""
echo "PRESIDENT: 各Workerにタスクを割り当てます..."

# Zellijペイン間通信関数 (名前でフォーカス)
focus_pane_and_execute() {
    local target_pane_name="$1"
    local cmd_to_run="$2"
    
    echo ">>> Worker $target_pane_name で実行中: $cmd_to_run"
    
    # 名前でペインにフォーカス
    zellij action focus-pane-name "$target_pane_name"
    
    # コマンドを書き込む
    zellij action write-chars "$cmd_to_run"
    
    # Enterキーを押してコマンド実行
    zellij action write 13  # ASCII 13 = Enter
    
    # 元のペイン（President）に戻る
    zellij action focus-pane-name "a"
    
    sleep 2 # コマンド実行のための短い待機
}

# シェルエスケープ関数
quote_for_shell() {
    echo "'$(echo "$1" | sed "s/'/'\\''/g")'"
}

# 各Workerに分解されたタスクを割り当て
echo "================================================="
echo ">>> WORKER B への技術的分析タスク割り当て..."
echo "================================================="
# TASK_Bが空でないか確認
if [ -n "$TASK_B" ]; then
    # シングルクォートを安全にエスケープしてコマンドを作成
    CMD_B="gemini -p $(quote_for_shell "$TASK_B")"
    focus_pane_and_execute "b" "$CMD_B"
else
    echo "Worker Bのタスクが生成されませんでした。"
fi

echo ""
echo "================================================="
echo ">>> WORKER C への現状動向分析タスク割り当て..."
echo "================================================="
if [ -n "$TASK_C" ]; then
    CMD_C="gemini -p $(quote_for_shell "$TASK_C")"
    focus_pane_and_execute "c" "$CMD_C"
else
    echo "Worker Cのタスクが生成されませんでした。"
fi

echo ""
echo "================================================="
echo ">>> WORKER D への将来展望分析タスク割り当て..."
echo "================================================="
if [ -n "$TASK_D" ]; then
    CMD_D="gemini -p $(quote_for_shell "$TASK_D")"
    focus_pane_and_execute "d" "$CMD_D"
else
    echo "Worker Dのタスクが生成されませんでした。"
fi

echo ""
echo "====================================================================="
echo "PRESIDENT: 全てのタスクを各Workerに割り当てました。報告を待機します。"
echo "====================================================================="
