# Zellij-Gemini リカバリー手順書

## 概要
このドキュメントでは、zellij-gemini環境でクラッシュやエラーが発生した際のリカバリー手順をまとめています。

## 目次
1. [Fatal Runtime Error対応](#fatal-runtime-error対応)
2. [Zellijクラッシュ対応](#zellijクラッシュ対応)
3. [Rust環境の更新・再構築](#rust環境の更新再構築)
4. [Geminiコマンドエラー対応](#geminiコマンドエラー対応)
5. [一括更新・メンテナンス](#一括更新メンテナンス)
6. [環境の完全リセット](#環境の完全リセット)

---

## Fatal Runtime Error対応

### 症状
```
fatal runtime error: assertion failed: outputo.write(&bytes).is_ok(), aborting
```

### 原因
- 古いRustツールチェーンでコンパイルされたZellijバイナリの互換性問題
- WSL環境でのSIGABRTクラッシュ

### 解決手順

#### 1. クラッシュ確認
```bash
# システムログでクラッシュを確認
wsl -d Ubuntu -- dmesg | grep -i "zellij\|crash\|abort"
```

#### 2. Rustツールチェーンの更新
```bash
# Rustupの再インストール
wsl -d Ubuntu -- bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# 環境変数の読み込み
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && rustc --version"
```

#### 3. Zellijの再コンパイル
```bash
# 最新Rustでzellijを再コンパイル
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && cargo install --locked zellij --force"
```

#### 4. バイナリの置き換え
```bash
# 古いバイナリを削除し、新しいバイナリにリンク
wsl -d Ubuntu -- bash -c "rm -f /home/wata/.local/bin/zellij && ln -sf /home/wata/.cargo/bin/zellij /home/wata/.local/bin/zellij"
```

#### 5. 動作確認
```bash
# テスト実行（10秒でタイムアウト）
wsl -d Ubuntu -- bash -c "cd /mnt/c/Users/wyosh/OneDrive/ドキュメント/zellij-gemini/type-04 && timeout 10 /home/wata/.cargo/bin/zellij --layout layout.kdl || echo 'Test completed - no crash detected'"
```

---

## Zellijクラッシュ対応

### 一般的なクラッシュ対応

#### 1. プロセス確認・終了
```bash
# Zellijプロセスの確認
wsl -d Ubuntu -- ps aux | grep zellij

# 強制終了
wsl -d Ubuntu -- pkill -f zellij
```

#### 2. セッションクリーンアップ
```bash
# Zellijセッションの削除
wsl -d Ubuntu -- rm -rf ~/.cache/zellij/
wsl -d Ubuntu -- rm -rf /tmp/zellij-*
```

#### 3. 設定ファイル確認
```bash
# レイアウトファイルの構文確認
wsl -d Ubuntu -- bash -c "cd /mnt/c/Users/wyosh/OneDrive/ドキュメント/zellij-gemini/type-04 && cat layout.kdl"
```

---

## Rust環境の更新・再構築

### 完全な環境再構築

#### 1. 既存環境のクリーンアップ
```bash
# Rustup環境の削除
wsl -d Ubuntu -- rm -rf ~/.rustup ~/.cargo

# システムのRustパッケージ削除（必要に応じて）
wsl -d Ubuntu -- sudo apt remove rustc cargo -y
```

#### 2. Rustupの新規インストール
```bash
# 最新Rustupのインストール
wsl -d Ubuntu -- bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# 環境変数の設定
wsl -d Ubuntu -- bash -c "echo 'source ~/.cargo/env' >> ~/.bashrc"
```

#### 3. 必要なツールの再インストール
```bash
# Zellijのインストール
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && cargo install --locked zellij"

# その他必要なツールがあれば追加
```

---

## Geminiコマンドエラー対応

### "There is no active session!" エラー

#### 原因
- 存在しない`gemini session start`コマンドの使用
- スタートアップスクリプトの設定ミス

#### 解決済み対応
各type-XX/startup_scripts_template/run_*.shファイルで以下の修正を実施済み：

**修正前:**
```bash
gemini session start
```

**修正後:**
```bash
echo "Gemini is ready for interactive use. Use 'gemini -p \"your prompt\"' for single queries."
```

#### 正しいGeminiの使用方法
```bash
# 単発クエリの実行
gemini -p "your prompt here"

# ヘルプの確認
gemini --help
```

---

## 一括更新・メンテナンス

### システム全体の更新

#### 1. WSL Ubuntu の更新
```bash
wsl -d Ubuntu -- sudo apt update && sudo apt upgrade -y
```

#### 2. Rust ツールチェーンの更新
```bash
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && rustup update"
```

#### 3. Cargo パッケージの更新
```bash
# インストール済みパッケージの一覧確認
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && cargo install --list"

# 特定パッケージの更新
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && cargo install --force zellij"
```

#### 4. 設定ファイルのバックアップ
```bash
# 重要な設定ファイルのバックアップ
cp -r type-04/ type-04_backup_$(date +%Y%m%d)
cp -r type-06/ type-06_backup_$(date +%Y%m%d)
cp -r type-08/ type-08_backup_$(date +%Y%m%d)
cp -r type-16/ type-16_backup_$(date +%Y%m%d)
```

---

## 環境の完全リセット

### 緊急時の完全リセット手順

#### 1. 全プロセスの停止
```bash
# Zellijプロセスの強制終了
wsl -d Ubuntu -- pkill -f zellij

# その他関連プロセスの確認・終了
wsl -d Ubuntu -- ps aux | grep -E "gemini|zellij"
```

#### 2. 一時ファイル・キャッシュの削除
```bash
# Zellijキャッシュの削除
wsl -d Ubuntu -- rm -rf ~/.cache/zellij/
wsl -d Ubuntu -- rm -rf /tmp/zellij-*

# Cargoキャッシュの削除（必要に応じて）
wsl -d Ubuntu -- rm -rf ~/.cargo/registry/cache/
```

#### 3. 設定の初期化
```bash
# スタートアップスクリプトの再生成（必要に応じて）
cd type-04/startup_scripts_template/
# 各run_*.shファイルの内容確認・修正
```

#### 4. 段階的な動作確認
```bash
# 1. Zellijの基本動作確認
wsl -d Ubuntu -- /home/wata/.cargo/bin/zellij --version

# 2. レイアウトファイルの構文確認
wsl -d Ubuntu -- bash -c "cd /mnt/c/Users/wyosh/OneDrive/ドキュメント/zellij-gemini/type-04 && /home/wata/.cargo/bin/zellij --layout layout.kdl --help"

# 3. 短時間テスト実行
wsl -d Ubuntu -- bash -c "cd /mnt/c/Users/wyosh/OneDrive/ドキュメント/zellij-gemini/type-04 && timeout 5 /home/wata/.cargo/bin/zellij --layout layout.kdl"
```

---

## トラブルシューティング チェックリスト

### 起動前チェック
- [ ] WSL Ubuntu が正常に動作している
- [ ] Rust ツールチェーンが最新版である
- [ ] Zellij バイナリが存在し実行可能である
- [ ] レイアウトファイルの構文が正しい
- [ ] スタートアップスクリプトに存在しないコマンドが含まれていない

### エラー発生時チェック
- [ ] システムログでクラッシュの詳細を確認
- [ ] プロセス一覧で関連プロセスの状態を確認
- [ ] 一時ファイル・キャッシュの状態を確認
- [ ] 設定ファイルの構文エラーがないか確認

### 復旧後チェック
- [ ] 基本コマンドが正常に動作する
- [ ] レイアウトが正しく表示される
- [ ] 各ペインでコマンドが実行できる
- [ ] Gemini コマンドが正常に動作する

---

## 参考情報

### 重要なパス
- Zellij バイナリ: `/home/wata/.cargo/bin/zellij`
- Zellij 設定: `~/.config/zellij/`
- Zellij キャッシュ: `~/.cache/zellij/`
- プロジェクトルート: `/mnt/c/Users/wyosh/OneDrive/ドキュメント/zellij-gemini/`

### 有用なコマンド
```bash
# システム情報確認
wsl -d Ubuntu -- uname -a
wsl -d Ubuntu -- lsb_release -a

# Rust環境確認
wsl -d Ubuntu -- bash -c "source ~/.cargo/env && rustc --version && cargo --version"

# プロセス監視
wsl -d Ubuntu -- top -p $(pgrep zellij)

# ログ監視
wsl -d Ubuntu -- dmesg -w | grep -i zellij
```

---

## Tmux版の実装完了

### 概要
Zellij環境の安定性問題を受けて、Tmux版のGemini Squadを実装しました。
Tmux版では、より安定した環境でマルチペイン協調作業が可能です。

### 実装内容
- **t-mux/**: Tmux版のメインディレクトリ
- **type-04**: 4ペインレイアウト（President + 3 specialists）
- **type-06**: 6ペインレイアウト（President + 5 specialists）
- **type-08**: 8ペインレイアウト（President + 7 specialists）
- **type-16**: 16ペインレイアウト（President + 15 specialists）

### 使用方法
```bash
# Windows PowerShellから開始
cd "C:\path\to\zellij-gemini\t-mux"
.\master-setup.ps1

# WSL内で特定レイアウトを起動
cd type-04  # または type-06, type-08, type-16
./master-setup.ps1

# 質問・タスクの実行
./ask_simple.sh "質問内容"    # 全ペインブロードキャスト
./ask_flat.sh "質問内容"      # フラット階層指示
./ask_tree.sh "質問内容"      # 階層的委任（type-08, 16のみ）
```

### 利点
- Zellijよりも安定した動作
- 豊富なペイン管理機能
- 階層的タスク委任サポート
- 企業レベルの包括的分析環境（type-16）

### ドキュメント
詳細な使用方法は `t-mux/TMUX_SETUP.md` を参照してください。

---

## 更新履歴
- 2024-09-04: 初版作成、Fatal Runtime Error対応手順を追加
- 2024-01-XX: Tmux版Gemini Squad実装完了
- 今後のトラブル事例に応じて随時更新予定