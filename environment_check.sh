#!/bin/bash
# environment_check.sh - Zellij-Gemini環境チェックスクリプト

echo "========================================"
echo "Zellij-Gemini 環境チェックスクリプト"
echo "========================================"

# 関数：チェック結果を表示
check_result() {
    if [ $1 -eq 0 ]; then
        echo "✅ $2"
    else
        echo "❌ $2"
    fi
}

echo ""
echo "1. 必要なツールのインストール確認"
echo "----------------------------------------"

# Zellij
if command -v zellij &> /dev/null; then
    check_result 0 "Zellij がインストールされています"
    echo "   バージョン: $(zellij --version)"
else
    check_result 1 "Zellij がインストールされていません"
    echo "   インストール方法: cargo install --locked zellij"
fi

# Gemini CLI
if command -v gemini &> /dev/null; then
    check_result 0 "Gemini CLI がインストールされています"
    echo "   パス: $(which gemini)"
else
    check_result 1 "Gemini CLI がインストールされていません"
    echo "   インストール方法: go install github.com/google/generative-ai-go/cmd/gemini@latest"
fi

# bat
if command -v bat &> /dev/null; then
    check_result 0 "bat がインストールされています"
    echo "   バージョン: $(bat --version)"
else
    check_result 1 "bat がインストールされていません"
    echo "   インストール方法: sudo apt install -y bat && sudo ln -s /usr/bin/batcat /usr/local/bin/bat"
fi

echo ""
echo "2. プロジェクトファイル構造確認"
echo "----------------------------------------"

# type-04確認
if [ -d "type-04" ]; then
    check_result 0 "type-04 ディレクトリが存在します"
    
    if [ -f "type-04/layout.kdl" ]; then
        check_result 0 "type-04/layout.kdl が存在します"
    else
        check_result 1 "type-04/layout.kdl が見つかりません"
    fi
    
    if [ -f "type-04/ask_flat.sh" ]; then
        check_result 0 "type-04/ask_flat.sh が存在します"
    else
        check_result 1 "type-04/ask_flat.sh が見つかりません"
    fi
    
    if [ -f "type-04/master-setup.ps1" ]; then
        check_result 0 "type-04/master-setup.ps1 が存在します"
    else
        check_result 1 "type-04/master-setup.ps1 が見つかりません"
    fi
else
    check_result 1 "type-04 ディレクトリが見つかりません"
fi

# type-06確認
if [ -d "type-06" ]; then
    check_result 0 "type-06 ディレクトリが存在します"
    
    if [ -f "type-06/layout.yaml" ]; then
        check_result 0 "type-06/layout.yaml が存在します"
    else
        check_result 1 "type-06/layout.yaml が見つかりません"
    fi
    
    if [ -f "type-06/ask_tree.sh" ]; then
        check_result 0 "type-06/ask_tree.sh が存在します"
    else
        check_result 1 "type-06/ask_tree.sh が見つかりません"
    fi
    
    if [ -f "type-06/master-setup.ps1" ]; then
        check_result 0 "type-06/master-setup.ps1 が存在します"
    else
        check_result 1 "type-06/master-setup.ps1 が見つかりません"
    fi
else
    check_result 1 "type-06 ディレクトリが見つかりません"
fi

echo ""
echo "3. スクリプト実行権限確認"
echo "----------------------------------------"

# type-04
for script in type-04/startup_scripts/*.sh type-04/ask_flat.sh; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            check_result 0 "$script に実行権限があります"
        else
            check_result 1 "$script に実行権限がありません"
            echo "   修正方法: chmod +x $script"
        fi
    fi
done

# type-06
for script in type-06/startup_scripts/*.sh type-06/ask_tree.sh; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            check_result 0 "$script に実行権限があります"
        else
            check_result 1 "$script に実行権限がありません"
            echo "   修正方法: chmod +x $script"
        fi
    fi
done

echo ""
echo "4. APIキー設定確認"
echo "----------------------------------------"

# type-04 APIキー確認
echo "type-04 APIキー設定:"
for script in type-04/startup_scripts/run_*.sh; do
    if [ -f "$script" ]; then
        pane_name=$(basename "$script" .sh | sed 's/run_//')
        # APIキーの確認方法を変更：環境変数の存在を確認
        if grep -q "source ../load_env.sh" "$script"; then
            echo "   ✅ ペイン $pane_name: 環境変数読み込み設定済み"
        else
            echo "   ❌ ペイン $pane_name: 環境変数読み込み設定なし"
        fi
    fi
done

echo ""
echo "type-06 APIキー設定:"
for script in type-06/startup_scripts/run_*.sh; do
    if [ -f "$script" ]; then
        pane_name=$(basename "$script" .sh | sed 's/run_//')
        # APIキーの確認方法を変更：環境変数の存在を確認
        if grep -q "source ../load_env.sh" "$script"; then
            echo "   ✅ ペイン $pane_name: 環境変数読み込み設定済み"
        else
            echo "   ❌ ペイン $pane_name: 環境変数読み込み設定なし"
        fi
    fi
done

echo ""
echo "========================================"
echo "環境チェック完了"
echo "========================================"
echo ""
echo "📋 次のステップ:"
echo "1. 不足しているツールをインストール"
echo "2. 実行権限のないスクリプトに chmod +x を適用"
echo "3. プロジェクトルートの.envファイルにAPIキーを設定"
echo "4. type-04 または type-06 の master-setup.ps1 を実行してテスト"
echo ""