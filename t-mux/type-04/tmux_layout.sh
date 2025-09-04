#!/bin/bash
# tmux_layout.sh - type-04 (4分割) tmuxレイアウト設定

# 共通設定を読み込み
source ../common/load_env.sh

# セッション名
SESSION_NAME="gemini-squad-4"

# tmuxが利用可能かチェック
if ! check_tmux_available; then
    exit 1
fi

echo "===================================================================="
echo "Tmux Gemini Project (4分割) セッションを開始します"
echo "セッション名: $SESSION_NAME"
echo "===================================================================="

# 既存セッションがある場合は終了
if check_tmux_session "$SESSION_NAME"; then
    echo "既存のセッション '$SESSION_NAME' を終了します..."
    kill_tmux_session "$SESSION_NAME"
    sleep 1
fi

# 新しいセッションを作成
echo "新しいセッション '$SESSION_NAME' を作成します..."
tmux new-session -d -s "$SESSION_NAME" -x 120 -y 30

# ペイン0 (President - a) の設定
echo "ペイン0 (President - a) を設定中..."
set_pane_title "$SESSION_NAME" "0" "President-a"
send_to_pane "$SESSION_NAME" "0" "cd \"$(pwd)\"" true
send_to_pane "$SESSION_NAME" "0" "chmod +x startup_scripts_template/*.sh ask_flat.sh" true
send_to_pane "$SESSION_NAME" "0" "startup_scripts_template/run_a.sh" false

# ペイン1 (Worker B - b) を作成
echo "ペイン1 (Worker B - b) を作成中..."
split_vertical "$SESSION_NAME" "0"
set_pane_title "$SESSION_NAME" "1" "Worker-b"
send_to_pane "$SESSION_NAME" "1" "cd \"$(pwd)\"" true
send_to_pane "$SESSION_NAME" "1" "startup_scripts_template/run_b.sh" false

# ペイン2 (Worker C - c) を作成
echo "ペイン2 (Worker C - c) を作成中..."
split_horizontal "$SESSION_NAME" "1"
set_pane_title "$SESSION_NAME" "2" "Worker-c"
send_to_pane "$SESSION_NAME" "2" "cd \"$(pwd)\"" true
send_to_pane "$SESSION_NAME" "2" "startup_scripts_template/run_c.sh" false

# ペイン3 (Worker D - d) を作成
echo "ペイン3 (Worker D - d) を作成中..."
split_vertical "$SESSION_NAME" "0"
set_pane_title "$SESSION_NAME" "3" "Worker-d"
send_to_pane "$SESSION_NAME" "3" "cd \"$(pwd)\"" true
send_to_pane "$SESSION_NAME" "3" "startup_scripts_template/run_d.sh" false

# レイアウトを調整
echo "レイアウトを調整中..."
# President (ペイン0) を上部に配置し、高さを調整
resize_pane "$SESSION_NAME" "0" "up" "5"
# Worker B (ペイン1) とWorker C (ペイン2) を中段に配置
resize_pane "$SESSION_NAME" "1" "right" "10"
# Worker D (ペイン3) を下段に配置
resize_pane "$SESSION_NAME" "3" "down" "5"

# Presidentペインにフォーカス
focus_pane "$SESSION_NAME" "0"

echo "===================================================================="
echo "tmuxセッション '$SESSION_NAME' が正常に作成されました"
echo "以下のコマンドでセッションにアタッチできます:"
echo "  tmux attach-session -t $SESSION_NAME"
echo ""
echo "ペイン構成:"
echo "  ペイン0: President (a) - タスク分解・指示出し・結果統合"
echo "  ペイン1: Worker B (b) - 技術的側面の分析担当"
echo "  ペイン2: Worker C (c) - 現状動向の分析担当"
echo "  ペイン3: Worker D (d) - 将来展望の分析担当"
echo ""
echo "使用方法:"
echo "  1. 各ペインでEnterキーを押して起動スクリプトを実行"
echo "  2. President (ペイン0) で './ask_flat.sh \"質問\"' を実行"
echo "===================================================================="

# デバッグ情報を表示
if [ "${DEBUG_TMUX:-false}" = "true" ]; then
    debug_session_info "$SESSION_NAME"
fi

# セッションにアタッチするかユーザーに確認
printf "セッションにアタッチしますか? (y/N): "
read REPLY
case "$REPLY" in
    [Yy]*) tmux attach-session -t "$SESSION_NAME" ;;
    *) echo "セッション作成完了" ;;
esac