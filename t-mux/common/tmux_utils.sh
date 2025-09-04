#!/bin/bash
# tmux_utils.sh - tmux共通関数ライブラリ

# tmuxセッションが存在するかチェック
check_tmux_session() {
    local session_name="$1"
    tmux has-session -t "$session_name" 2>/dev/null
}

# tmuxセッションを作成（既存の場合は何もしない）
create_tmux_session() {
    local session_name="$1"
    if ! check_tmux_session "$session_name"; then
        tmux new-session -d -s "$session_name"
        echo "tmuxセッション '$session_name' を作成しました"
    else
        echo "tmuxセッション '$session_name' は既に存在します"
    fi
}

# ペインにコマンドを送信
send_to_pane() {
    local session_name="$1"
    local pane_id="$2"
    local command="$3"
    local execute="${4:-true}"  # デフォルトで実行
    
    if [ "$execute" = "true" ]; then
        tmux send-keys -t "${session_name}:0.${pane_id}" "$command" Enter
    else
        tmux send-keys -t "${session_name}:0.${pane_id}" "$command"
    fi
}

# ペインにフォーカス
focus_pane() {
    local session_name="$1"
    local pane_id="$2"
    tmux select-pane -t "${session_name}:0.${pane_id}"
}

# ペインを水平分割
split_horizontal() {
    local session_name="$1"
    local target_pane="${2:-0}"
    tmux split-window -h -t "${session_name}:0.${target_pane}"
}

# ペインを垂直分割
split_vertical() {
    local session_name="$1"
    local target_pane="${2:-0}"
    tmux split-window -v -t "${session_name}:0.${target_pane}"
}

# ペインのサイズを調整
resize_pane() {
    local session_name="$1"
    local pane_id="$2"
    local direction="$3"  # up, down, left, right
    local size="$4"
    case "$direction" in
        "up") tmux resize-pane -t "${session_name}:0.${pane_id}" -U "$size" ;;
        "down") tmux resize-pane -t "${session_name}:0.${pane_id}" -D "$size" ;;
        "left") tmux resize-pane -t "${session_name}:0.${pane_id}" -L "$size" ;;
        "right") tmux resize-pane -t "${session_name}:0.${pane_id}" -R "$size" ;;
    esac
}

# ペインにタイトルを設定
set_pane_title() {
    local session_name="$1"
    local pane_id="$2"
    local title="$3"
    tmux select-pane -t "${session_name}:0.${pane_id}" -T "$title"
}

# セッション内の全ペインを表示
list_panes() {
    local session_name="$1"
    tmux list-panes -t "$session_name" -F "#{pane_id}: #{pane_title} (#{pane_current_command})"
}

# ペイン間通信用の関数（Zellijのfocus_pane_and_executeに相当）
focus_pane_and_execute() {
    local session_name="$1"
    local target_pane="$2"
    local cmd_to_run="$3"
    local return_pane="${4:-0}"  # 戻り先ペイン（デフォルトは0）
    
    echo ">>> ペイン $target_pane で実行中: $cmd_to_run"
    
    # 対象ペインにフォーカス
    focus_pane "$session_name" "$target_pane"
    
    # コマンドを送信して実行
    send_to_pane "$session_name" "$target_pane" "$cmd_to_run" true
    
    # 元のペインに戻る
    focus_pane "$session_name" "$return_pane"
    
    sleep 2  # コマンド実行のための短い待機
}

# tmuxセッションを終了
kill_tmux_session() {
    local session_name="$1"
    if check_tmux_session "$session_name"; then
        tmux kill-session -t "$session_name"
        echo "tmuxセッション '$session_name' を終了しました"
    else
        echo "tmuxセッション '$session_name' は存在しません"
    fi
}

# tmuxが利用可能かチェック
check_tmux_available() {
    if ! command -v tmux &> /dev/null; then
        echo "エラー: tmuxがインストールされていません"
        echo "インストール方法: sudo apt-get install tmux"
        return 1
    fi
    return 0
}

# tmuxのバージョンを表示
show_tmux_version() {
    tmux -V
}

# デバッグ用: セッション情報を表示
debug_session_info() {
    local session_name="$1"
    echo "=== tmuxセッション情報 ==="
    echo "セッション名: $session_name"
    echo "セッション存在確認: $(check_tmux_session "$session_name" && echo '存在' || echo '不存在')"
    if check_tmux_session "$session_name"; then
        echo "ペイン一覧:"
        list_panes "$session_name"
    fi
    echo "========================="
}