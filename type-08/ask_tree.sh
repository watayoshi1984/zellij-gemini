#!/bin/bash
# 使い方: ./ask_tree.sh "実行させたい質問"
if [ "$#" -ne 1 ]; then echo "使い方: $0 \"<質問>\""; exit 1; fi
QUESTION="$1"

echo "====================================================================="
echo "PRESIDENT: 技術・ビジネス双軸で「$QUESTION」を分析指示します"
echo "====================================================================="

# Presidentがタスク分解を行う
TASK_DECOMPOSITION_PROMPT="以下の質問「$QUESTION」について、技術とビジネスの双軸で分析を行うためのタスクを作成してください。

Technical Boss B: 技術グループ統括（Worker C、D、E管理）
- Worker C: システム設計・アーキテクチャ
- Worker D: 実装・開発・技術詳細  
- Worker E: 品質・テスト・技術検証

Business Boss F: ビジネスグループ統括（Worker G、H管理）
- Worker G: 市場分析・顧客ニーズ
- Worker H: 事業戦略・収益モデル

両Bossが各Workerを統括し、技術とビジネスの統合報告をPresidentに提出する構造で進めてください。"

echo "PRESIDENT: 双軸タスク分解中..."
gemini -p "$TASK_DECOMPOSITION_PROMPT"

# 現在のZellijバージョンに対応したペイン間通信関数
focus_pane_and_execute() {
    local target_pane="$1"
    local cmd_to_run="$2"
    
    echo ">>> $target_pane で実行中: $cmd_to_run"
    
    # 8分割レイアウトに基づく正しいペインフォーカス移動
    case "$target_pane" in
        "b") zellij action move-focus down ;;
        "f") zellij action move-focus down; zellij action move-focus right ;;
        "c") zellij action move-focus down; zellij action move-focus down ;;
        "d") zellij action move-focus down; zellij action move-focus down; zellij action move-focus down ;;
        "e") zellij action move-focus down; zellij action move-focus down; zellij action move-focus down; zellij action move-focus down ;;
        "g") zellij action move-focus down; zellij action move-focus down; zellij action move-focus right ;;
        "h") zellij action move-focus down; zellij action move-focus down; zellij action move-focus right; zellij action move-focus down ;;
    esac
    
    zellij action write-chars "$cmd_to_run"
    zellij action write 13
    
    # 元のペイン（President）に戻る
    case "$target_pane" in
        "b") zellij action move-focus up ;;
        "f") zellij action move-focus left; zellij action move-focus up ;;
        "c") zellij action move-focus up; zellij action move-focus up ;;
        "d") zellij action move-focus up; zellij action move-focus up; zellij action move-focus up; zellij action move-focus up ;;
        "e") zellij action move-focus up; zellij action move-focus up; zellij action move-focus up; zellij action move-focus up; zellij action move-focus up ;;
        "g") zellij action move-focus left; zellij action move-focus up; zellij action move-focus up ;;
        "h") zellij action move-focus up; zellij action move-focus left; zellij action move-focus up; zellij action move-focus up ;;
    esac
    
    sleep 2
}

# Technical Boss Bに技術統括指示
echo "================================================="
echo ">>> TECHNICAL BOSS B への技術統括指示..."
echo "================================================="
TECH_BOSS_TASK="「$QUESTION」について、技術グループで以下の各Workerから専門分析を依頼し、技術統合報告をPresidentに提出してください。

Worker C担当: システム設計・アーキテクチャの詳細分析
Worker D担当: 実装・開発の詳細分析
Worker E担当: 品質・テストの詳細分析

各Workerの技術分析結果を統合し、技術的実現可能性の総合評価をPresidentに報告してください。"

focus_pane_and_execute "b" "gemini -p '$TECH_BOSS_TASK'"

echo ""
echo "================================================="
echo ">>> BUSINESS BOSS F へのビジネス統括指示..."
echo "================================================="
BUSINESS_BOSS_TASK="「$QUESTION」について、ビジネスグループで以下の各Workerから専門分析を依頼し、ビジネス統合報告をPresidentに提出してください。

Worker G担当: 市場分析・顧客ニーズの詳細分析
Worker H担当: 事業戦略・収益モデルの詳細分析

各Workerのビジネス分析結果を統合し、事業性と市場競争力の総合評価をPresidentに報告してください。"

focus_pane_and_execute "f" "gemini -p '$BUSINESS_BOSS_TASK'"

echo ""
echo "====================================================================="
echo "PRESIDENT: 技術・ビジネス双軸での統括指示を完了。両Boss主導での実行を待機します。"
echo "====================================================================="