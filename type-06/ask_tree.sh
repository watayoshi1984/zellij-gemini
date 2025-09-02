#!/bin/bash
# 使い方: ./ask_tree.sh "実行させたい質問"
if [ "$#" -ne 1 ]; then echo "使い方: $0 \"<質問>\""; exit 1; fi
QUESTION="$1"

echo "====================================================================="
echo "PRESIDENT: 受け取った質問「$QUESTION」を階層的にタスク分解してBossに指示します"
echo "====================================================================="

# Presidentがタスク分解を行う
TASK_DECOMPOSITION_PROMPT="以下の質問「$QUESTION」について、階層的な分析を行うためのタスクを作成してください。
Boss B: 各Workerの統括と技術・市場・ビジネス視点の統合
Worker C: 技術的な側面や仕組みについて詳細分析
Worker D: 現在の動向や最新情報について詳細分析  
Worker E: 将来展望や社会への影響について詳細分析
Worker F: リスク評価や課題分析について詳細分析

Boss Bが各Workerを統括し、Presidentに統合報告を行う構造で進めてください。"

echo "PRESIDENT: 階層的タスク分解中..."
gemini -p "$TASK_DECOMPOSITION_PROMPT"

echo ""
echo "PRESIDENT: Boss Bに指示を出します..."

# 現在のZellijバージョンに対応したペイン間通信関数
focus_pane_and_execute() {
    local target_pane="$1"
    local cmd_to_run="$2"
    
    echo ">>> $target_pane で実行中: $cmd_to_run"
    
    # 6分割レイアウトに基づく正しいペインフォーカス移動
    case "$target_pane" in
        "b")
            zellij action move-focus down
            ;;
        "c") 
            zellij action move-focus down
            zellij action move-focus down
            ;;
        "d")
            zellij action move-focus down  
            zellij action move-focus down
            zellij action move-focus right
            ;;
        "e")
            zellij action move-focus down
            zellij action move-focus down
            zellij action move-focus right
            zellij action move-focus right
            ;;
        "f")
            zellij action move-focus down
            zellij action move-focus down
            zellij action move-focus right
            zellij action move-focus right
            zellij action move-focus right
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
            zellij action move-focus up
            zellij action move-focus up
            ;;
        "d")
            zellij action move-focus left
            zellij action move-focus up
            zellij action move-focus up
            ;;
        "e")
            zellij action move-focus left
            zellij action move-focus left
            zellij action move-focus up
            zellij action move-focus up
            ;;
        "f")
            zellij action move-focus left
            zellij action move-focus left
            zellij action move-focus left
            zellij action move-focus up
            zellij action move-focus up
            ;;
    esac
    
    sleep 2  # 実行結果を待つ
}

# Boss Bに統括指示を出す
echo "================================================="
echo ">>> BOSS B への統括指示..."
echo "================================================="
BOSS_TASK="「$QUESTION」について、以下の各Workerから専門分野の分析を依頼し、統合報告をPresidentに提出してください。

Worker C担当: 技術的な側面や仕組みの詳細分析
Worker D担当: 現在の動向や最新情報の詳細分析  
Worker E担当: 将来展望や社会への影響の詳細分析
Worker F担当: リスク評価や課題分析の詳細分析

各Workerの分析結果を統合し、包括的な結論をPresidentに報告してください。"

focus_pane_and_execute "b" "gemini -p '$BOSS_TASK'"

echo ""
echo "====================================================================="
echo "PRESIDENT: Boss Bに統括指示を出しました。Boss主導での階層実行を待機します。"
echo "====================================================================="