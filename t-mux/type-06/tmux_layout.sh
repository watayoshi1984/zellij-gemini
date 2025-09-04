#!/bin/bash
# tmux_layout.sh - type-06 (6-pane hierarchical layout)
# 階層構造: President(a) -> Boss(b) -> Workers(c,d,e,f)

# 共通設定を読み込み
source "../common/load_env.sh"

# tmuxがインストールされているかチェック
if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed. Please install tmux first."
    echo "Install command: sudo apt-get update && sudo apt-get install tmux"
    exit 1
fi

# セッション名を設定
SESSION_NAME="gemini-squad-6"

# 既存のセッションがあるかチェック
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists."
    echo "To kill existing session: tmux kill-session -t $SESSION_NAME"
    echo "To attach to existing session: tmux attach-session -t $SESSION_NAME"
    exit 1
fi

echo "Creating tmux session: $SESSION_NAME"
echo "Layout: 6-pane hierarchical structure"
echo "Structure: President(a) -> Boss(b) -> Workers(c,d,e,f)"
echo ""

# 新しいセッションを作成（最初のペインはPresident-a）
tmux new-session -d -s "$SESSION_NAME" -n "gemini-squad"

# ペインのタイトルを設定（President-a）
tmux select-pane -t "$SESSION_NAME:0.0" -T "President-a"

# 右側に縦分割してBoss-bペインを作成
tmux split-window -h -t "$SESSION_NAME:0.0"
tmux select-pane -t "$SESSION_NAME:0.1" -T "Boss-b"

# 右側（Boss-b側）を上下に分割してWorker-cペインを作成
tmux split-window -v -t "$SESSION_NAME:0.1"
tmux select-pane -t "$SESSION_NAME:0.2" -T "Worker-c"

# Worker-c側を右に分割してWorker-dペインを作成
tmux split-window -h -t "$SESSION_NAME:0.2"
tmux select-pane -t "$SESSION_NAME:0.3" -T "Worker-d"

# Boss-b側を下に分割してWorker-eペインを作成
tmux split-window -v -t "$SESSION_NAME:0.1"
tmux select-pane -t "$SESSION_NAME:0.4" -T "Worker-e"

# Worker-e側を右に分割してWorker-fペインを作成
tmux split-window -h -t "$SESSION_NAME:0.4"
tmux select-pane -t "$SESSION_NAME:0.5" -T "Worker-f"

# レイアウトを調整（President-aを大きく、Boss-bを中程度、Workersを小さく）
tmux resize-pane -t "$SESSION_NAME:0.0" -x 40  # President-a: 幅40%
tmux resize-pane -t "$SESSION_NAME:0.1" -x 30  # Boss-b: 幅30%

# 各ペインで初期コマンドを実行
echo "Setting up panes..."

# President-a ペイン
tmux send-keys -t "$SESSION_NAME:0.0" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.0" "chmod +x startup_scripts_template/*.sh ask_tree.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.0" "./startup_scripts_template/run_a.sh" Enter

# Boss-b ペイン
tmux send-keys -t "$SESSION_NAME:0.1" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.1" "chmod +x startup_scripts_template/*.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.1" "./startup_scripts_template/run_b.sh" Enter

# Worker-c ペイン
tmux send-keys -t "$SESSION_NAME:0.2" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.2" "chmod +x startup_scripts_template/*.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.2" "./startup_scripts_template/run_c.sh" Enter

# Worker-d ペイン
tmux send-keys -t "$SESSION_NAME:0.3" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.3" "chmod +x startup_scripts_template/*.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.3" "./startup_scripts_template/run_d.sh" Enter

# Worker-e ペイン
tmux send-keys -t "$SESSION_NAME:0.4" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.4" "chmod +x startup_scripts_template/*.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.4" "./startup_scripts_template/run_e.sh" Enter

# Worker-f ペイン
tmux send-keys -t "$SESSION_NAME:0.5" "cd $(pwd)" Enter
tmux send-keys -t "$SESSION_NAME:0.5" "chmod +x startup_scripts_template/*.sh" Enter
tmux send-keys -t "$SESSION_NAME:0.5" "./startup_scripts_template/run_f.sh" Enter

# President-aペインにフォーカスを戻す
tmux select-pane -t "$SESSION_NAME:0.0"

echo ""
echo "✅ Tmux session '$SESSION_NAME' created successfully!"
echo ""
echo "📋 Session Layout (6-pane hierarchical):"
echo "   ┌─────────────┬─────────────┐"
echo "   │             │   Boss-b    │"
echo "   │ President-a ├──────┬──────┤"
echo "   │             │ Wkr-c│ Wkr-d│"
echo "   │             ├──────┼──────┤"
echo "   │             │ Wkr-e│ Wkr-f│"
echo "   └─────────────┴──────┴──────┘"
echo ""
echo "🚀 Usage:"
echo "   1. Attach to session: tmux attach-session -t $SESSION_NAME"
echo "   2. In President-a pane: ./ask_tree.sh \"your question\""
echo "   3. Switch panes: Ctrl+b + Arrow keys"
echo "   4. Detach session: Ctrl+b + d"
echo ""
echo "📝 Hierarchy:"
echo "   President(a) -> Boss(b) -> Workers(c,d,e,f)"
echo "   - President: Overall decision making"
echo "   - Boss: Middle management, worker coordination"
echo "   - Workers: Specialized task execution"
echo ""
echo "🔧 Management:"
echo "   - List sessions: tmux list-sessions"
echo "   - Kill session: tmux kill-session -t $SESSION_NAME"
echo ""