#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}"
export CLAUDE_API_KEY="${CLAUDE_API_KEY_A:-YOUR_API_KEY_FOR_A}"

# 指示書ファイルのパス
INSTRUCTION_FILE="instructions/a_president.md"

# jqコマンドの存在確認
if ! command -v jq &> /dev/null;
then
    echo "エラー: このスクリプトの実行には 'jq' が必要です。"
    echo "jqをインストールしてください。 (e.g., sudo apt-get install jq)"
    exec $SHELL
fi

# 指示書が存在するか確認
if [ ! -f "$INSTRUCTION_FILE" ]; then
  echo "エラー: 指示書ファイルが見つかりません: $INSTRUCTION_FILE"
  exec $SHELL
fi

# 最初に一度だけ指示書の内容を表示 (ページャなし)
/usr/local/bin/bat --paging=never "$INSTRUCTION_FILE"
echo "=================================================="
echo "大統領(a)のタスク管理システム"
echo "以下に指示を入力し、Enterキーを押してください。"
echo "終了するには Ctrl+C を押してください。"
echo "=================================================="

# 指示書の内容をメモリに読み込む
instruction_base=$(cat "$INSTRUCTION_FILE")

# 無限ループでユーザーからの入力を待つ
while true; do
  read -p "指示: " user_input

  if [ -z "$user_input" ]; then
    continue
  fi

  full_prompt=$(printf "%s\n\n## ユーザーからの指示\n%s" "$instruction_base" "$user_input")

  # gemini cliにプロンプトを渡して実行し、応答を変数に格納
  response=$(gemini -p "$full_prompt")

  # 応答からJSONブロックのみを抽出
  # まず ```json ... ``` ブロックを探す
  json_block=$(echo "$response" | awk '/```json/{flag=1; next} /```/{flag=0} flag')

  # もし見つからなければ、裸の { ... } ブロックを探す
  if [ -z "$json_block" ]; then
      json_block=$(echo "$response" | awk '/{/{r=1} r; /}/{exit} ')
  fi

  # 抽出したJSONブロックが有効かチェック
  if [ -n "$json_block" ] && echo "$json_block" | jq -e 'has("tasks")' > /dev/null;
  then
    # JSONとして処理
    speak_text=$(echo "$json_block" | jq -r '.speak // ""')
    if [ -n "$speak_text" ]; then
        echo "AI: $speak_text"
    fi

    # タスクを実行
    echo "タスクを割り当て中..."
    echo "$json_block" | jq -c '.tasks[]' | while read -r task;
    do
      pane_name=$(echo "$task" | jq -r '.pane')
      instruction_text=$(echo "$task" | jq -r '.instruction')

      command_to_send="gemini -p \"${instruction_text}\""
      pipe_file="/tmp/zellij_gemini_pane_${pane_name}"

      echo "  - ペイン '${pane_name}' へ指示: ${instruction_text}"
      
      if [ -p "$pipe_file" ]; then
        echo "$command_to_send" > "$pipe_file"
      else
        echo "エラー: ペイン '${pane_name}' のパイプが見つかりません: $pipe_file"
      fi
    done
  else
    # JSONが見つからなかった場合、元の応答をそのまま表示
    echo "AI: $response"
  fi

  echo ""
  echo "--------------------------------------------------"
  echo "次の指示を入力してください (終了は Ctrl+C)。"
done