#!/bin/bash
# .envファイルを読み込む
source ../load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数GEMINI_API_KEY_Aを設定 ★★★
export CLAUDE_API_KEY="${CLAUDE_API_KEY_A:-YOUR_API_KEY_FOR_A}" # ★★★ 環境変数CLAUDE_API_KEY_Aを設定 ★★★

# 指示書ファイルのパス
INSTRUCTION_FILE="instructions/a_president.md"

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
  # プロンプトを表示してユーザー入力を待つ
  read -p "指示: " user_input

  # ユーザー入力が空の場合はループの最初に戻る
  if [ -z "$user_input" ]; then
    continue
  fi

  # 指示書とユーザー入力を結合して最終的なプロンプトを作成
  full_prompt=$(printf "%s\n\n## ユーザーからの指示\n%s" "$instruction_base" "$user_input")

  # gemini cliにプロンプトを渡して実行
  if command -v gemini &> /dev/null; then
    gemini -p "$full_prompt"
  else
    echo "エラー: 'gemini'コマンドが見つかりません。パスを確認してください。"
  fi

  echo ""
  echo "--------------------------------------------------"
  echo "次の指示を入力してください (終了は Ctrl+C)。"
done
