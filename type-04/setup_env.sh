#!/bin/bash
# setup_env.sh - APIキー環境変数設定スクリプト

echo "============================================"
echo "Zellij-Gemini APIキー環境変数設定"
echo "============================================"

# .envファイルが存在しない場合は作成
if [ ! -f "../.env" ]; then
    echo "# Zellij-Gemini APIキー設定ファイル" > ../.env
    echo "# このファイルに実際のAPIキーを設定してください" >> ../.env
    echo "" >> ../.env
    echo "# type-04 APIキー" >> ../.env
    echo "GEMINI_API_KEY_A=YOUR_GEMINI_API_KEY_FOR_A" >> ../.env
    echo "GEMINI_API_KEY_B=YOUR_GEMINI_API_KEY_FOR_B" >> ../.env
    echo "GEMINI_API_KEY_C=YOUR_GEMINI_API_KEY_FOR_C" >> ../.env
    echo "GEMINI_API_KEY_D=YOUR_GEMINI_API_KEY_FOR_D" >> ../.env
    echo "" >> ../.env
    echo "# type-06 APIキー" >> ../.env
    echo "GEMINI_API_KEY_E=YOUR_GEMINI_API_KEY_FOR_E" >> ../.env
    echo "GEMINI_API_KEY_F=YOUR_GEMINI_API_KEY_FOR_F" >> ../.env
    echo "" >> ../.env
    echo "# type-08 APIキー" >> ../.env
    echo "GEMINI_API_KEY_G=YOUR_GEMINI_API_KEY_FOR_G" >> ../.env
    echo "GEMINI_API_KEY_H=YOUR_GEMINI_API_KEY_FOR_H" >> ../.env
    echo "" >> ../.env
    echo "# Claude Code APIキー (必要に応じて設定)" >> ../.env
    echo "CLAUDE_API_KEY_A=YOUR_CLAUDE_API_KEY_FOR_A" >> ../.env
    echo "CLAUDE_API_KEY_B=YOUR_CLAUDE_API_KEY_FOR_B" >> ../.env
    echo "CLAUDE_API_KEY_C=YOUR_CLAUDE_API_KEY_FOR_C" >> ../.env
    echo "CLAUDE_API_KEY_D=YOUR_CLAUDE_API_KEY_FOR_D" >> ../.env
    echo "CLAUDE_API_KEY_E=YOUR_CLAUDE_API_KEY_FOR_E" >> ../.env
    echo "CLAUDE_API_KEY_F=YOUR_CLAUDE_API_KEY_FOR_F" >> ../.env
    echo "CLAUDE_API_KEY_G=YOUR_CLAUDE_API_KEY_FOR_G" >> ../.env
    echo "CLAUDE_API_KEY_H=YOUR_CLAUDE_API_KEY_FOR_H" >> ../.env
    echo ".envファイルを作成しました。実際のAPIキーを設定してください。"
else
    echo ".envファイルは既に存在します。"
fi

# 古いstartup_scriptsとログを削除
echo "クリーンアップ処理を実行中..."
rm -rf startup_scripts
rm -f log
echo "クリーンアップ完了。"

# startup_scriptsディレクトリを作成
mkdir -p startup_scripts

# テンプレートからstartup_scriptsにコピー
echo "startup_scriptsファイルを生成中..."

for script in startup_scripts_template/run_*.sh; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        target="startup_scripts/$script_name"
        
        cp "$script" "$target"
        chmod +x "$target"
        echo "生成完了: $target"
    fi
done

echo ""
echo "✅ セットアップ完了！"
echo "以下の手順で続行してください："
echo "1. プロジェクトルートの.envファイルに実際のAPIキーを設定してください。"
echo "2. 以下のコマンドでZellijを起動してください："
echo "   zellij --layout layout.kdl"