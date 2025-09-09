#!/bin/bash
# 手動統合スクリプト - Worker B、C、Dの成果物を統合

cd "$(dirname "$0")"

# 出力ディレクトリの作成
mkdir -p out_put/a

# 統合レポートの生成
FINAL_OUTPUT="out_put/a/final_manual_$(date +%s).md"

echo "# 最終統合レポート - Reactベストプラクティス調査" > "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"
echo "生成日時: $(date)" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"

# Worker Bの成果物を統合
echo "## Worker B: 技術的ベストプラクティス" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"
if [ -f "artifacts/b_20250906_221322.txt" ]; then
    cat "artifacts/b_20250906_221322.txt" >> "$FINAL_OUTPUT"
else
    echo "Worker Bの成果物が見つかりません。" >> "$FINAL_OUTPUT"
fi
echo "" >> "$FINAL_OUTPUT"
echo "---" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"

# Worker Cの成果物を統合
echo "## Worker C: エコシステムトレンド" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"
if [ -f "artifacts/c_20250906_221323.txt" ]; then
    cat "artifacts/c_20250906_221323.txt" >> "$FINAL_OUTPUT"
else
    echo "Worker Cの成果物が見つかりません。" >> "$FINAL_OUTPUT"
fi
echo "" >> "$FINAL_OUTPUT"
echo "---" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"

# Worker Dの成果物を統合
echo "## Worker D: 将来展望分析" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"
if [ -f "artifacts/d_20250906_221324.txt" ]; then
    cat "artifacts/d_20250906_221324.txt" >> "$FINAL_OUTPUT"
else
    echo "Worker Dの成果物が見つかりません。" >> "$FINAL_OUTPUT"
fi
echo "" >> "$FINAL_OUTPUT"
echo "---" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"

# 統合完了メッセージ
echo "## 統合完了" >> "$FINAL_OUTPUT"
echo "" >> "$FINAL_OUTPUT"
echo "全てのWorkerタスクの成果物を統合しました。" >> "$FINAL_OUTPUT"
echo "統合ファイル: $FINAL_OUTPUT" >> "$FINAL_OUTPUT"

echo "統合処理完了: $FINAL_OUTPUT"
echo "統合されたレポートを確認してください。"