#!/bin/bash
# load_env.sh - 共通環境変数読み込みファイル

# .envファイルが存在する場合は読み込む
if [ -f "../.env" ]; then
    source ../.env
    echo "環境変数ファイル (.env) を読み込みました"
elif [ -f "../../.env" ]; then
    source ../../.env
    echo "環境変数ファイル (../../.env) を読み込みました"
else
    echo "警告: .envファイルが見つかりません。デフォルト設定を使用します。"
fi

# デフォルトAPIキー設定（実際の使用時は.envファイルまたは環境変数で設定）
[ -z "$GEMINI_API_KEY_A" ] && export GEMINI_API_KEY_A="YOUR_API_KEY_FOR_A"
[ -z "$GEMINI_API_KEY_B" ] && export GEMINI_API_KEY_B="YOUR_API_KEY_FOR_B"
[ -z "$GEMINI_API_KEY_C" ] && export GEMINI_API_KEY_C="YOUR_API_KEY_FOR_C"
[ -z "$GEMINI_API_KEY_D" ] && export GEMINI_API_KEY_D="YOUR_API_KEY_FOR_D"
[ -z "$GEMINI_API_KEY_E" ] && export GEMINI_API_KEY_E="YOUR_API_KEY_FOR_E"
[ -z "$GEMINI_API_KEY_F" ] && export GEMINI_API_KEY_F="YOUR_API_KEY_FOR_F"
[ -z "$GEMINI_API_KEY_G" ] && export GEMINI_API_KEY_G="YOUR_API_KEY_FOR_G"
[ -z "$GEMINI_API_KEY_H" ] && export GEMINI_API_KEY_H="YOUR_API_KEY_FOR_H"
[ -z "$GEMINI_API_KEY_I" ] && export GEMINI_API_KEY_I="YOUR_API_KEY_FOR_I"
[ -z "$GEMINI_API_KEY_J" ] && export GEMINI_API_KEY_J="YOUR_API_KEY_FOR_J"
[ -z "$GEMINI_API_KEY_K" ] && export GEMINI_API_KEY_K="YOUR_API_KEY_FOR_K"
[ -z "$GEMINI_API_KEY_L" ] && export GEMINI_API_KEY_L="YOUR_API_KEY_FOR_L"
[ -z "$GEMINI_API_KEY_M" ] && export GEMINI_API_KEY_M="YOUR_API_KEY_FOR_M"
[ -z "$GEMINI_API_KEY_N" ] && export GEMINI_API_KEY_N="YOUR_API_KEY_FOR_N"
[ -z "$GEMINI_API_KEY_O" ] && export GEMINI_API_KEY_O="YOUR_API_KEY_FOR_O"
[ -z "$GEMINI_API_KEY_P" ] && export GEMINI_API_KEY_P="YOUR_API_KEY_FOR_P"

# Claude APIキー設定
[ -z "$CLAUDE_API_KEY_A" ] && export CLAUDE_API_KEY_A="YOUR_API_KEY_FOR_A"
[ -z "$CLAUDE_API_KEY_B" ] && export CLAUDE_API_KEY_B="YOUR_API_KEY_FOR_B"
[ -z "$CLAUDE_API_KEY_C" ] && export CLAUDE_API_KEY_C="YOUR_API_KEY_FOR_C"
[ -z "$CLAUDE_API_KEY_D" ] && export CLAUDE_API_KEY_D="YOUR_API_KEY_FOR_D"
[ -z "$CLAUDE_API_KEY_E" ] && export CLAUDE_API_KEY_E="YOUR_API_KEY_FOR_E"
[ -z "$CLAUDE_API_KEY_F" ] && export CLAUDE_API_KEY_F="YOUR_API_KEY_FOR_F"
[ -z "$CLAUDE_API_KEY_G" ] && export CLAUDE_API_KEY_G="YOUR_API_KEY_FOR_G"
[ -z "$CLAUDE_API_KEY_H" ] && export CLAUDE_API_KEY_H="YOUR_API_KEY_FOR_H"
[ -z "$CLAUDE_API_KEY_I" ] && export CLAUDE_API_KEY_I="YOUR_API_KEY_FOR_I"
[ -z "$CLAUDE_API_KEY_J" ] && export CLAUDE_API_KEY_J="YOUR_API_KEY_FOR_J"
[ -z "$CLAUDE_API_KEY_K" ] && export CLAUDE_API_KEY_K="YOUR_API_KEY_FOR_K"
[ -z "$CLAUDE_API_KEY_L" ] && export CLAUDE_API_KEY_L="YOUR_API_KEY_FOR_L"
[ -z "$CLAUDE_API_KEY_M" ] && export CLAUDE_API_KEY_M="YOUR_API_KEY_FOR_M"
[ -z "$CLAUDE_API_KEY_N" ] && export CLAUDE_API_KEY_N="YOUR_API_KEY_FOR_N"
[ -z "$CLAUDE_API_KEY_O" ] && export CLAUDE_API_KEY_O="YOUR_API_KEY_FOR_O"
[ -z "$CLAUDE_API_KEY_P" ] && export CLAUDE_API_KEY_P="YOUR_API_KEY_FOR_P"

# tmux設定
[ -z "$TMUX_SESSION_NAME" ] && export TMUX_SESSION_NAME="gemini-squad"

# 共通パス設定
# load_env.sh自体のディレクトリを取得（sh互換）
# このスクリプトは../common/load_env.shとして呼び出されるため、
# 呼び出し元のディレクトリから../commonを指定
CURRENT_DIR="$(pwd)"
export COMMON_DIR="$(cd "$CURRENT_DIR/../common" 2>/dev/null && pwd)"
if [ -z "$COMMON_DIR" ]; then
    # フォールバック: 現在のディレクトリ
    export COMMON_DIR="$CURRENT_DIR"
fi
export PROJECT_ROOT="$(cd "$COMMON_DIR/.." && pwd)"

# tmux共通関数を読み込み
if [ -f "$COMMON_DIR/tmux_utils.sh" ]; then
    source "$COMMON_DIR/tmux_utils.sh"
else
    echo "警告: tmux_utils.sh が見つかりません"
fi

# デバッグ情報（必要に応じてコメントアウト）
[ -z "$DEBUG_ENV" ] && DEBUG_ENV="false"
if [ "$DEBUG_ENV" = "true" ]; then
    echo "=== 環境変数デバッグ情報 ==="
    echo "COMMON_DIR: $COMMON_DIR"
    echo "PROJECT_ROOT: $PROJECT_ROOT"
    echo "TMUX_SESSION_NAME: $TMUX_SESSION_NAME"
    echo "============================="
fi

echo "共通環境設定を読み込みました"