#!/bin/bash
# .envファイルを読み込む
# スクリプトの実行ディレクトリをtype-04に変更
cd "$(dirname "$0")/.."
source load_env.sh

export GEMINI_API_KEY="${GEMINI_API_KEY_A:-YOUR_API_KEY_FOR_A}"
export CLAUDE_API_KEY="${CLAUDE_API_KEY_A:-YOUR_API_KEY_FOR_A}"

# 受信レポート用パイプと成果物出力先
REPORT_PIPE="/tmp/zellij_gemini_report_a"
ARTIFACTS_DIR="out_put/a"
mkdir -p "$ARTIFACTS_DIR"

# 既存のパイプがあれば作り直す
if [ -p "$REPORT_PIPE" ]; then
  rm -f "$REPORT_PIPE"
fi
mkfifo "$REPORT_PIPE"
# 終了時に片付け
trap 'rm -f "$REPORT_PIPE"' EXIT

# シェル安全なクオート関数（シングルクオートで囲む）
shell_escape() {
  printf %s "$1" | sed "s/'/'\\''/g; s/.*/'&'/"
}

# バッチ完了時の統合処理
finalize_batch() {
  local job_id="$1"
  local expected_file="/tmp/zellij_gemini_batch_${job_id}.expected"
  local reports_file="/tmp/zellij_gemini_batch_${job_id}.jsonl"
  local format_file="/tmp/zellij_gemini_batch_${job_id}.format"
  local final_format="md"
  [ -f "$format_file" ] && final_format=$(cat "$format_file")
  mkdir -p "$ARTIFACTS_DIR"
  local final_path="${ARTIFACTS_DIR}/final_${job_id}.${final_format}"
  echo "PRESIDENT: 最終出力先: $final_path"

  if [ ! -f "$reports_file" ]; then
    echo "PRESIDENT: レポートファイルが見つかりません (job_id: $job_id)" >&2
    return 1
  fi

  if [ "$final_format" = "json" ]; then
    # JSONの配列として統合
    jq -s --slurpfile meta <(jq -n --arg job_id "$job_id" --arg final_format "$final_format" '{job_id:$job_id,final_format:$final_format}') '($meta[0]) + {reports: .}' "$reports_file" > "$final_path"
  else
    # md / txt は素直に結合
    {
      echo "# 最終統合レポート (job_id: $job_id)"
      echo ""
      while IFS= read -r line; do
        pane=$(echo "$line" | jq -r '.pane')
        filename=$(echo "$line" | jq -r '.filename')
        content=$(echo "$line" | jq -r '.content')
        success=$(echo "$line" | jq -r '.success // 0')
        attempts=$(echo "$line" | jq -r '.attempts // 1')
        echo "## Pane ${pane}"
        echo "- 生成ファイル: ${filename}"
        echo "- ステータス: $( [ "$success" -eq 1 ] && echo 成功 || echo 失敗 ) (試行: ${attempts})"
        echo ""
        echo "$content"
        echo ""
      done < "$reports_file"
    } > "$final_path"
  fi
  echo "PRESIDENT: 全タスク完了を検知 (job_id: $job_id)。最終出力: $final_path"
}

# 背景でレポート受信リスナーを起動
(
  while true; do
    if [ -p "$REPORT_PIPE" ]; then
      if read -r payload < "$REPORT_PIPE"; then
        if echo "$payload" | jq -e . > /dev/null 2>&1; then
          # スキーマバリデーション（固定スキーマ）
          if ! echo "$payload" | jq -e 'type=="object" and .type=="completion" and (.pane|type=="string") and ((.job_id|type=="string") or (.job_id|type=="number")) and (.filename|type=="string") and (.content|type=="string") and ((.success|type=="boolean") or (.success|type=="number")) and (.attempts|type=="number")' > /dev/null 2>&1; then
            echo "警告: スキーマ不正なJSONレポートを受信: $payload" >&2
            continue
          fi
          job_id=$(echo "$payload" | jq -r '.job_id // empty')
          pane=$(echo "$payload" | jq -r '.pane // empty')
          if [ -n "$job_id" ]; then
            reports_file="/tmp/zellij_gemini_batch_${job_id}.jsonl"
            echo "$payload" >> "$reports_file"
            expected_file="/tmp/zellij_gemini_batch_${job_id}.expected"
            if [ -f "$expected_file" ]; then
              expected=$(cat "$expected_file")
              received=$(wc -l < "$reports_file" | tr -d ' ')
              echo "PRESIDENT: 進捗 (job_id: $job_id) $received/$expected (from pane $pane)"
              if [ "$received" -ge "$expected" ]; then
                finalize_batch "$job_id"
              fi
            fi
          fi
        else
          echo "警告: 無効なJSONレポートを受信: $payload" >&2
        fi
      fi
    else
      sleep 0.1
    fi
  done
) &

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

# 最初に一度だけ指示書の内容を表示
# 既定は cat を使用。USE_BAT=1 かつ Zellij でない環境のみ bat を試行
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
  echo "AI応答を取得中..."
  echo "[DEBUG] Gemini CLI呼び出し開始: $(date)" >> a.log
  echo "[DEBUG] プロンプト長: ${#full_prompt} 文字" >> a.log
  
  # Gemini CLI呼び出しのリトライロジック
  MAX_RETRY_PRESIDENT=${MAX_RETRY_PRESIDENT:-3}
  attempt=1
  response=""
  
  while [ "$attempt" -le "$MAX_RETRY_PRESIDENT" ]; do
    echo "[DEBUG] Gemini CLI試行 $attempt/$MAX_RETRY_PRESIDENT" >> a.log
    response=$(gemini -p "$full_prompt" 2>&1)
    status=$?
    
    if [ "$status" -eq 0 ]; then
      echo "[DEBUG] Gemini CLI成功 (試行: $attempt)" >> a.log
      break
    else
      echo "[ERROR] Gemini CLI失敗 (試行: $attempt, 終了コード: $status)" >> a.log
      echo "[ERROR] エラー内容: $response" >> a.log
      
      if echo "$response" | grep -q "429" || echo "$response" | grep -q "rateLimitExceeded"; then
        echo "[ERROR] レート制限エラー検出" >> a.log
      fi
      
      if [ "$attempt" -lt "$MAX_RETRY_PRESIDENT" ]; then
        if [ "$attempt" -eq 1 ]; then
          backoff=5
        elif [ "$attempt" -eq 2 ]; then
          backoff=15
        else
          backoff=30
        fi
        echo "[DEBUG] ${backoff}秒待機後に再試行" >> a.log
        sleep "$backoff"
      fi
      attempt=$((attempt+1))
    fi
  done
  
  if [ "$attempt" -gt "$MAX_RETRY_PRESIDENT" ]; then
    echo "[ERROR] Gemini CLI最大試行回数に達しました" >> a.log
    echo "AI: エラー - Gemini APIへの接続に失敗しました。しばらく待ってから再試行してください。"
    continue
  fi

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
    thought_text=$(echo "$json_block" | jq -r '.thought // ""')
    speak_text=$(echo "$json_block" | jq -r '.speak // ""')
    
    # 思考プロセスを表示
    if [ -n "$thought_text" ]; then
        echo "AI思考: $thought_text"
    fi
    
    # 発言を表示
    if [ -n "$speak_text" ]; then
        echo "AI: $speak_text"
    fi

    # 出力形式とバッチID、期待数を確定
    job_id=$(date +%s%N)
    tasks_count=$(echo "$json_block" | jq '.tasks | length')
    final_format=$(echo "$json_block" | jq -r '.final_format // "md"')
    echo "$tasks_count" > "/tmp/zellij_gemini_batch_${job_id}.expected"
    echo "$final_format" > "/tmp/zellij_gemini_batch_${job_id}.format"

    # タスクを実行
    echo "タスクを割り当て中... (job_id: $job_id, tasks: $tasks_count, format: $final_format)"
    echo "$json_block" | jq -c '.tasks[]' | while read -r task;
    do
      pane_name=$(echo "$task" | jq -r '.pane')
      instruction_text=$(echo "$task" | jq -r '.instruction')
      instr_escaped=$(shell_escape "$instruction_text")

      # Workerで実行する複合コマンド（スロットリング + 成果物保存 + リトライ + レポート送信）
      command_to_send="echo \"[DEBUG] タスク開始: $(date)\" >> ${pane_name}.log; PANE=${pane_name}; JOB_ID=${job_id}; FINAL_FORMAT=${final_format}; REPORT_PIPE=${REPORT_PIPE}; ARTDIR=out_put/${pane_name}; mkdir -p \"\$ARTDIR\"; JITTER_MS=\\$((RANDOM%1500+500)); echo \"[DEBUG] 初期待機: \${JITTER_MS}ms\" >> ${pane_name}.log; sleep \\$(printf \"0.%03d\" \"\$JITTER_MS\"); MAX_RETRY=\\${MAX_RETRY:-5}; attempt=1; success=0; OUTPUT=\"\"; while [ \"\$attempt\" -le \"\$MAX_RETRY\" ]; do echo \"[DEBUG] API呼び出し試行 \$attempt/\$MAX_RETRY ($(date))\" >> ${pane_name}.log; echo \"[${pane_name}] API呼び出し試行 \$attempt/\$MAX_RETRY...\"; OUTPUT=\\$(gemini -p ${instr_escaped} 2>&1); status=\\$?; echo \"[DEBUG] API応答ステータス: \$status\" >> ${pane_name}.log; if [ \"\$status\" -eq 0 ]; then success=1; echo \"[DEBUG] API呼び出し成功\" >> ${pane_name}.log; break; fi; echo \"[ERROR] API呼び出し失敗: \$OUTPUT\" >> ${pane_name}.log; if echo \"\$OUTPUT\" | grep -q \"429\" || echo \"\$OUTPUT\" | grep -q \"rateLimitExceeded\"; then echo \"[ERROR] レート制限エラー検出\" >> ${pane_name}.log; echo \"[${pane_name}] レート制限エラー検出。待機中...\"; fi; if [ \"\$attempt\" -eq 1 ]; then backoff=10; elif [ \"\$attempt\" -eq 2 ]; then backoff=30; elif [ \"\$attempt\" -eq 3 ]; then backoff=60; elif [ \"\$attempt\" -eq 4 ]; then backoff=120; else backoff=300; fi; jitter=\\$((RANDOM%5000+2000)); echo \"[DEBUG] 待機時間: \${backoff}.\${jitter}秒\" >> ${pane_name}.log; sleep \\$(printf \"%d.%03d\" \"\$backoff\" \"\$jitter\"); attempt=\\$((attempt+1)); done; FILENAME=\"\$ARTDIR/${pane_name}_\\${JOB_ID}.\\${FINAL_FORMAT}\"; printf \"%s\\n\" \"\$OUTPUT\" > \"\$FILENAME\"; USED_ATTEMPTS=\\$MAX_RETRY; if [ \"\$success\" -eq 1 ]; then USED_ATTEMPTS=\\$attempt; echo \"[DEBUG] 最終結果: 成功 (試行回数: \$attempt)\" >> ${pane_name}.log; echo \"[${pane_name}] API呼び出し成功 (試行回数: \$attempt)\"; else echo \"[ERROR] 最終結果: 失敗 (最大試行回数に達しました)\" >> ${pane_name}.log; echo \"[${pane_name}] API呼び出し失敗 (最大試行回数に達しました)\"; fi; echo \"[DEBUG] レポート送信開始\" >> ${pane_name}.log; jq -n --arg type \"completion\" --arg pane \"${pane_name}\" --arg job_id \"${job_id}\" --arg filename \"\$FILENAME\" --arg content \"\$OUTPUT\" --argjson success \"\$success\" --argjson attempts \"\$USED_ATTEMPTS\" '{\"type\":\$type,\"pane\":\$pane,\"job_id\":\$job_id,\"filename\":\$filename,\"content\":\$content,\"success\":\$success,\"attempts\":\$attempts}' > \"${REPORT_PIPE}\"; echo \"[DEBUG] レポート送信完了\" >> ${pane_name}.log; echo \"[${pane_name}] 完了報告を送信 (job_id: ${job_id}) -> \$FILENAME (success=\$success attempts=\$USED_ATTEMPTS)\""
      pipe_file="/tmp/zellij_gemini_pane_${pane_name}"

      echo "  - ペイン '${pane_name}' へ指示: ${instruction_text}"
      echo "[DEBUG] タスク送信: pane=${pane_name}, job_id=${job_id}" >> a.log
      
      if [ -p "$pipe_file" ]; then
        echo "[DEBUG] パイプ送信成功: $pipe_file" >> a.log
        echo "$command_to_send" > "$pipe_file"
      else
        echo "[ERROR] パイプが見つかりません: $pipe_file" >> a.log
        echo "エラー: ペイン '${pane_name}' のパイプが見つかりません: $pipe_file"
      fi

      # 送信間隔のスロットリング（軽い間隔を空ける）
      sleep "${RATE_LIMIT_SEND_GAP_SEC:-0.10}"
    done
  else
    # JSONが見つからなかった場合、元の応答をそのまま表示
    echo "AI: $response"
  fi

  echo ""
  echo "--------------------------------------------------"
  echo "次の指示を入力してください (終了は Ctrl+C)。"
done