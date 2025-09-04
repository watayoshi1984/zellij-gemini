#!/bin/bash
# start_tmux_session.sh
# Tmux セッション起動用の共通スクリプト

# 共通環境設定を読み込み
source "$(dirname "$0")/load_env.sh"

# 使用方法を表示する関数
show_usage() {
    echo "Usage: $0 <layout_type>"
    echo "Available layout types:"
    echo "  04 - 4-pane layout (President + 3 specialists)"
    echo "  06 - 6-pane layout (President + 5 specialists)"
    echo "  08 - 8-pane layout (President + 7 specialists)"
    echo "  16 - 16-pane layout (President + 15 specialists)"
    echo ""
    echo "Example: $0 04"
    exit 1
}

# 引数チェック
if [ $# -ne 1 ]; then
    show_usage
fi

LAYOUT_TYPE="$1"

# 有効なレイアウトタイプかチェック
case "$LAYOUT_TYPE" in
    04|06|08|16)
        ;;
    *)
        echo "Error: Invalid layout type '$LAYOUT_TYPE'"
        show_usage
        ;;
esac

# レイアウトディレクトリのパス
LAYOUT_DIR="$(dirname "$0")/type-$LAYOUT_TYPE"

# レイアウトディレクトリが存在するかチェック
if [ ! -d "$LAYOUT_DIR" ]; then
    echo "Error: Layout directory '$LAYOUT_DIR' not found"
    exit 1
fi

# レイアウトスクリプトが存在するかチェック
LAYOUT_SCRIPT="$LAYOUT_DIR/tmux_layout.sh"
if [ ! -f "$LAYOUT_SCRIPT" ]; then
    echo "Error: Layout script '$LAYOUT_SCRIPT' not found"
    exit 1
fi

# レイアウトスクリプトに実行権限を付与
chmod +x "$LAYOUT_SCRIPT"

echo "Starting Tmux session with type-$LAYOUT_TYPE layout..."
echo "Layout directory: $LAYOUT_DIR"
echo "Layout script: $LAYOUT_SCRIPT"
echo ""

# レイアウトディレクトリに移動してスクリプトを実行
cd "$LAYOUT_DIR" || exit 1
./tmux_layout.sh

echo ""
echo "Tmux session started successfully!"
echo "Use 'tmux attach-session -t gemini-squad-$LAYOUT_TYPE' to attach to the session."