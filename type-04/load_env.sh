#!/bin/bash
# load_env.sh - .envファイルから環境変数を読み込む

# .envファイルが存在するか確認
if [ -f "../.env" ]; then
    # .envファイルから環境変数をエクスポート
    export $(grep -v '^#' ../.env | xargs)
    echo ".envファイルからAPIキーを読み込みました。"
else
    echo "警告: .envファイルが見つかりません。"
    echo "APIキーが設定されていない可能性があります。"
fi