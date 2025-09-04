#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_B:-YOUR_API_KEY_FOR_B}"
export CLAUDE_API_KEY="${CLAUDE_API_KEY_B:-YOUR_API_KEY_FOR_B}"

PANE_NAME="b"
PIPE_FILE="/tmp/zellij_gemini_pane_${PANE_NAME}"
INSTRUCTION_FILE="instructions/${PANE_NAME}_worker.md"

# パイプが存在すれば削除
if [ -p "$PIPE_FILE" ]; then
  rm "$PIPE_FILE"
fi

# パイプを作成
mkfifo "$PIPE_FILE"

# スクリプト終了時にパイプを削除する
trap 'rm -f "$PIPE_FILE"' EXIT

# 最初に一度だけ指示書の内容を表示
if [ -f "$INSTRUCTION_FILE" ]; then
  /usr/local/bin/bat --paging=never "$INSTRUCTION_FILE"
fi
echo "=================================================="
echo "ワーカー(${PANE_NAME})は準備完了です。"
echo "パイプ '${PIPE_FILE}' で指示を待っています..."
echo "=================================================="

# パイプからコマンドを読み込んで実行するループ
while true; do
  # パイプが開かれるまでcatは待機する
  command_to_run=$(cat "$PIPE_FILE")
  
  # 読み込んだコマンドが空でなければ実行
  if [ -n "$command_to_run" ]; then
    echo ""
    echo "--- [指示受信] ---"
    echo "$ $command_to_run"
    echo "--- [実行開始] ---"
    eval "$command_to_run"
    echo "--- [実行完了] ---"
    echo ""
    echo "次の指示を待っています..."
  fi
done
