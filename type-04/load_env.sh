#!/bin/bash
# load_env.sh - .envファイルから環境変数を読み込む（スクリプト位置基準で安全に）

# このスクリプト自身のディレクトリ
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 優先順位: 親ディレクトリの.env -> 同ディレクトリの.env
if [ -f "$SCRIPT_DIR/../.env" ]; then
    set -a
    # shellcheck disable=SC2046
    export $(grep -v '^#' "$SCRIPT_DIR/../.env" | xargs)
    set +a
    echo ".envファイルを読み込みました: $SCRIPT_DIR/../.env"
elif [ -f "$SCRIPT_DIR/.env" ]; then
    set -a
    # shellcheck disable=SC2046
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
    set +a
    echo ".envファイルを読み込みました: $SCRIPT_DIR/.env"
else
    echo "警告: .envファイルが見つかりません ($SCRIPT_DIR および 親ディレクトリを確認)。"
    echo "APIキーが設定されていない可能性があります。"
fi