# Zellij-Gemini プロジェクト 起動・運用ガイド
cd type-04 && ./setup_env.sh
zellij --layout layout.kdl




## 概要
このガイドでは、任意の場所からPowerShellを起動した状態から、Zellij-GeminiプロジェクトのZellijおよびTmuxの分割ペインセットアップ、起動、シャットダウン、メンテナンスまでの全コマンドを説明します。

## 前提条件
- WSL (Windows Subsystem for Linux) がインストール済み
- PowerShell 7+ が利用可能
- Zellij および Tmux がWSL内にインストール済み
- Gemini API または Claude API キーが準備済み

---

## 1. プロジェクトディレクトリへの移動

### PowerShellからプロジェクトディレクトリに移動
```powershell
# プロジェクトディレクトリに移動
cd "C:\Users\wyosh\OneDrive\ドキュメント\zellij-gemini"

# 現在のディレクトリ確認
Get-Location
```

---

## 2. Zellij セットアップと起動

### 2.1 利用可能な構成
- **type-04**: 4分割（President + 3Workers）
- **type-06**: 6分割（President + Boss + 4Workers）
- **type-08**: 8分割（President + 2Boss + 5Workers）
- **type-16**: 16分割（エンタープライズレベル）

### 2.2 Zellij起動コマンド

#### type-04 (4分割)
```powershell
# type-04ディレクトリに移動して起動
cd type-04
.\master-setup.ps1
```

#### type-06 (6分割)
```powershell
# type-06ディレクトリに移動して起動
cd type-06
.\master-setup.ps1
```

#### type-08 (8分割)
```powershell
# type-08ディレクトリに移動して起動
cd type-08
.\master-setup.ps1
```

#### type-16 (16分割)
```powershell
# type-16ディレクトリに移動して起動
cd type-16
.\master-setup.ps1
```

### 2.3 Zellij手動起動（WSL内）
```bash
# WSL内でZellijを手動起動する場合
zellij --layout layout.yaml  # type-06, type-08, type-16の場合
zellij --layout layout.kdl   # type-04の場合
```

### 2.4 Zellijセッション操作
```bash
# セッション一覧表示
zellij list-sessions

# セッションにアタッチ
zellij attach [session-name]

# セッションから離脱（Ctrl+P → D）
# またはコマンド
zellij action quit
```

---

## 3. Tmux セットアップと起動

### 3.1 利用可能な構成
- **type-04**: 4分割レイアウト
- **type-06**: 6分割レイアウト
- **type-08**: 8分割レイアウト
- **type-16**: 16分割レイアウト

### 3.2 Tmux起動コマンド

#### type-04 (4分割)
```powershell
# t-mux/type-04ディレクトリに移動して起動
cd t-mux\type-04
.\master-setup.ps1
```

#### type-06 (6分割)
```powershell
# t-mux/type-06ディレクトリに移動して起動
cd t-mux\type-06
.\master-setup.ps1
```

#### type-08 (8分割)
```powershell
# t-mux/type-08ディレクトリに移動して起動
cd t-mux\type-08
.\master-setup.ps1
```

#### type-16 (16分割)
```powershell
# t-mux/type-16ディレクトリに移動して起動
cd t-mux\type-16
.\master-setup.ps1
```

### 3.3 Tmux手動起動（WSL内）
```bash
# WSL内でTmuxを手動起動する場合
./tmux_layout.sh
```

### 3.4 Tmuxセッション操作
```bash
# セッション一覧表示
tmux list-sessions

# セッションにアタッチ
tmux attach-session -t [session-name]

# セッションから離脱（Ctrl+B → D）
# またはコマンド
tmux detach-session
```

---

## 4. API キー設定

### 4.1 startup_scriptsディレクトリでのAPI キー設定
各構成の `startup_scripts_template/` ディレクトリ内の `run_*.sh` ファイルを編集：

```bash
# Gemini API キーの場合
export GEMINI_API_KEY="your-gemini-api-key-here"

# Claude API キーの場合
export ANTHROPIC_API_KEY="your-claude-api-key-here"
```

### 4.2 環境変数ファイル（.env）の設定
```bash
# プロジェクトルートの.envファイルを編集
GEMINI_API_KEY=your-gemini-api-key-here
ANTHROPIC_API_KEY=your-claude-api-key-here
```

---

## 5. シャットダウン・終了コマンド

### 5.1 Zellijセッション終了
```bash
# 現在のセッションを終了
zellij action quit

# 全てのZellijセッションを強制終了
pkill -f zellij
```

### 5.2 Tmuxセッション終了
```bash
# 現在のセッションを終了
tmux kill-session

# 特定のセッションを終了
tmux kill-session -t [session-name]

# 全てのTmuxセッションを終了
tmux kill-server
```

### 5.3 WSLセッション終了
```powershell
# PowerShellからWSLを終了
wsl --shutdown
```

---

## 6. メンテナンス・トラブルシューティング

### 6.1 セッションクリーンアップ
```bash
# 残存プロセスの確認
ps aux | grep -E "(zellij|tmux)"

# 強制終了
pkill -f zellij
pkill -f tmux

# ソケットファイルのクリーンアップ
rm -rf /tmp/tmux-*
rm -rf /tmp/zellij-*
```

### 6.2 ログ確認
```bash
# Zellijログ確認
ls ~/.cache/zellij/

# Tmuxログ確認（各構成のlogsディレクトリ）
ls logs/
tail -f logs/*.log
```

### 6.3 権限修正
```bash
# スクリプトファイルに実行権限を付与
chmod +x startup_scripts/*.sh
chmod +x ask_*.sh
chmod +x tmux_layout.sh
```

### 6.4 環境チェック
```bash
# 環境チェックスクリプト実行
./environment_check.sh

# 依存関係確認
which zellij
which tmux
which geminicli
```

---

## 7. 高度な操作

### 7.1 カスタム設定
```bash
# Zellij設定ファイル編集
nano ~/.config/zellij/config.kdl

# Tmux設定ファイル編集
nano ~/.tmux.conf
```

### 7.2 セッション復旧
```bash
# recovery.mdファイルを参照
cat recovery.md

# セッション復旧スクリプト実行
./session_manager.sh recover
```

### 7.3 バックアップ・復元
```powershell
# 設定ファイルのバックアップ
Copy-Item -Recurse "C:\Users\wyosh\OneDrive\ドキュメント\zellij-gemini" "C:\Backup\zellij-gemini-$(Get-Date -Format 'yyyyMMdd')"
```

---

## 8. よくある問題と解決方法

### 8.1 「command not found」エラー
```bash
# PATHの確認と設定
echo $PATH
export PATH=$PATH:/usr/local/bin
```

### 8.2 API キーエラー
```bash
# 環境変数の確認
echo $GEMINI_API_KEY
echo $ANTHROPIC_API_KEY

# 環境変数の再読み込み
source ~/.bashrc
source .env
```

### 8.3 セッション接続エラー
```bash
# ソケットファイルの確認
ls -la /tmp/tmux-*
ls -la /tmp/zellij-*

# 権限修正
chmod 700 /tmp/tmux-*
```

---

## 9. クイックスタートコマンド集

### Zellij クイックスタート
```powershell
# type-08 Zellijを即座に起動
cd "C:\Users\wyosh\OneDrive\ドキュメント\zellij-gemini\type-08"
.\master-setup.ps1
```

### Tmux クイックスタート
```powershell
# type-08 Tmuxを即座に起動
cd "C:\Users\wyosh\OneDrive\ドキュメント\zellij-gemini\t-mux\type-08"
.\master-setup.ps1
```

### 完全リセット
```bash
# 全セッション終了とクリーンアップ
pkill -f zellij
pkill -f tmux
rm -rf /tmp/tmux-* /tmp/zellij-*
wsl --shutdown
```

---

## 10. 参考資料

- **work-flow.md**: 各構成の詳細な操作ガイド
- **recovery.md**: セッション復旧手順
- **README.md**: プロジェクト概要
- **TMUX_SETUP.md**: Tmux固有の設定ガイド

---

**注意**: このガイドは Windows + WSL 環境を前提としています。Linux や macOS では一部コマンドが異なる場合があります。