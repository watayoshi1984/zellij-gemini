#!/bin/bash
# .envファイルを読み込む
# スクリプトの実行ディレクトリをtype-04に変更
cd "$(dirname "$0")/.."
source load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_D:-YOUR_API_KEY_FOR_D}"
export CLAUDE_API_KEY="${CLAUDE_API_KEY_D:-YOUR_API_KEY_FOR_D}"

# jq の存在確認（レポート送信に使用）
if ! command -v jq >/dev/null 2>&1; then
  echo "警告: jq が見つかりません。レポート送信に必要です。sudo apt-get install -y jq を推奨します。"
fi

PANE_NAME="d"
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
# 既定は cat を使用。USE_BAT=1 かつ Zellij でない環境のみ bat を試行
if [ -f "$INSTRUCTION_FILE" ]; then
  if [ "${USE_BAT:-0}" = "1" ] && [ -z "${ZELLIJ:-}${ZELLIJ_PANE:-}" ]; then
    if command -v bat >/dev/null 2>&1; then
      bat --style=plain --color=never --paging=never "$INSTRUCTION_FILE" 2>/dev/null || cat "$INSTRUCTION_FILE"
    elif [ -x /usr/local/bin/bat ]; then
      /usr/local/bin/bat --style=plain --color=never --paging=never "$INSTRUCTION_FILE" 2>/dev/null || cat "$INSTRUCTION_FILE"
    else
      cat "$INSTRUCTION_FILE"
    fi
  else
    cat "$INSTRUCTION_FILE"
  fi
fi

echo "================================================="
echo "ワーカー(${PANE_NAME})は準備完了です。"
echo "パイプ '${PIPE_FILE}' で指示を待っています..."
echo "=================================================="

# デバッグログの初期化
echo "[DEBUG] ワーカー${PANE_NAME}起動: $(date)" > ${PANE_NAME}.log
echo "[DEBUG] 環境変数確認:" >> ${PANE_NAME}.log
echo "[DEBUG] GEMINI_API_KEY設定: $([ -n "$GEMINI_API_KEY" ] && echo "あり" || echo "なし")" >> ${PANE_NAME}.log
echo "[DEBUG] jq利用可能: $(command -v jq >/dev/null 2>&1 && echo "あり" || echo "なし")" >> ${PANE_NAME}.log
echo "[DEBUG] gemini CLI利用可能: $(command -v gemini >/dev/null 2>&1 && echo "あり" || echo "なし")" >> ${PANE_NAME}.log

# Presidentへの報告送信関数
send_report_to_president() {
  local job_id="$1"
  local output_file="$2"
  local success="$3"
  local content="$4"
  
  # Presidentへの報告パイプ
  local president_pipe="/tmp/zellij_gemini_pane_a"
  
  if [ -p "$president_pipe" ]; then
    # JSON形式で報告を作成
    local report=$(jq -n \
      --arg job_id "$job_id" \
      --arg pane "$PANE_NAME" \
      --arg filename "$output_file" \
      --arg content "$content" \
      --argjson success "$success" \
      --argjson attempts 1 \
      '{
        job_id: $job_id,
        pane: $pane,
        filename: $filename,
        content: $content,
        success: ($success | tonumber),
        attempts: ($attempts | tonumber)
      }')
    
    # Presidentに報告を送信
    echo "$report" > "$president_pipe"
    echo "[DEBUG] Presidentに報告送信: $report" >> ${PANE_NAME}.log
  else
    echo "[WARNING] Presidentパイプが見つかりません: $president_pipe" >> ${PANE_NAME}.log
  fi
}

# パイプからコマンドを読み込んで実行するループ
while true; do
  # パイプが開かれるまでcatは待機する
  command_to_run=$(cat "$PIPE_FILE")
  
  # 読み込んだコマンドが空でなければ実行
  if [ -n "$command_to_run" ]; then
    echo ""
    echo "--- [指示受信] ---"
    echo "$ $command_to_run"
    echo "[DEBUG] コマンド受信: $(date)" >> ${PANE_NAME}.log
    echo "[DEBUG] コマンド長: ${#command_to_run} 文字" >> ${PANE_NAME}.log
    echo "--- [実行開始] ---"
    
    # タイムスタンプ付きの出力ファイル名を生成
    timestamp=$(date +"%Y%m%d_%H%M%S")
    output_file="artifacts/${PANE_NAME}_${timestamp}.txt"
    job_id="${timestamp}"
    
    # コマンドを実行し、出力をファイルに保存
    eval "$command_to_run" > "$output_file" 2>&1
    exit_code=$?
    
    # 出力内容を読み込み（報告用）
    output_content=$(cat "$output_file" 2>/dev/null || echo "出力ファイルの読み込みに失敗")
    
    echo "[DEBUG] コマンド実行完了: 終了コード=$exit_code" >> ${PANE_NAME}.log
    echo "--- [実行完了] 終了コード=$exit_code ---"
    echo "出力ファイル: $output_file"
    
    # Presidentに完了報告を送信
    success_flag=$([ $exit_code -eq 0 ] && echo "1" || echo "0")
    send_report_to_president "$job_id" "$output_file" "$success_flag" "$output_content"
    
    echo "Presidentに完了報告を送信しました"
    echo ""
    echo "次の指示を待っています..."
  fi
done
