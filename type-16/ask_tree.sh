#!/bin/bash
# ペイン'a'から実行する階層型コマンド送信スクリプト
# 使い方: ./ask_tree.sh "実行させたい質問"

if [ "$#" -ne 1 ]; then
  echo "使い方: $0 \"<Geminiへの質問>\""
  exit 1
fi

QUESTION="$1"

# シェル関数を定義: zquery <target_pane> <"command">
# 外部の.zshrc等に依存せず、このスクリプト内で完結させる
zquery() {
  if [ "$#" -ne 2 ]; then echo "zquery usage: <target> \"<command>\""; return 1; fi
  local target_pane="$1"; local cmd_to_run="$2"
  local tmpfile=$(mktemp); local donefile="${tmpfile}.done"
  local full_cmd_on_target="{ ${cmd_to_run} ; } > ${tmpfile} 2>&1; touch ${donefile}"
  zellij action --target-pane "$target_pane" write-chars "${full_cmd_on_target}\n"
  while [ ! -f "$donefile" ]; do sleep 0.1; done
  cat "$tmpfile"
  rm "$tmpfile" "$donefile"
}

declare -A hierarchy
hierarchy["b"]="e f g h"
hierarchy["c"]="i j k l"
hierarchy["d"]="m n o p"

for parent_pane in "${!hierarchy[@]}"; do
  echo "================================================="
  echo ">>> DELEGATING TASK TO BOSS PANE '$parent_pane'..."
  echo "================================================="
  child_panes="${hierarchy[$parent_pane]}"
  
  command_for_parent="
    echo '--- Task execution started for workers under ($parent_pane) ---';
    for child in $child_panes; do
      echo \"--- Response from Worker [\$child] ---\";
      zquery \$child \"gemini chat '$QUESTION'\";
      echo;
    done;
    echo '--- All tasks under ($parent_pane) completed. ---';
  "

  zquery "$parent_pane" "$command_for_parent"
  echo
done
echo "ALL TASKS COMPLETED."