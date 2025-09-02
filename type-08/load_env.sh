#!/bin/bash
# load_env.sh - .envファイルを読み込むスクリプト

# プロジェクトルートの.envファイルを読み込む
if [ -f "../.env" ]; then
    export $(grep -v '^#' ../.env | xargs)
    echo ".envファイルを読み込みました"
else
    echo ".envファイルが見つかりません"
fi