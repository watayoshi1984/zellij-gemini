# Zellij-Gemini AI協調システム 操作ガイド

## 前提条件

### システム要件
- Windows 10/11 (64bit)
- WSL2 (Ubuntu推奨)
- PowerShell 5.1以上
- Git for Windows
- 安定したインターネット接続

### 必須パッケージとインストール方法

#### 1. WSL2とUbuntuのインストール
```powershell
# PowerShell（管理者権限）で実行
wsl --install
# または特定のディストリビューション
wsl --install -d Ubuntu
```

#### 2. Git for Windows
- 公式サイトからダウンロード: https://git-scm.com/download/win
- または Winget で:
```powershell
winget install --id Git.Git -e --source winget
```

#### 3. Rustのインストール（Zellij用）
```bash
# WSL内で実行
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

#### 4. Go言語のインストール（Gemini CLI用）
```bash
# WSL内で実行
# 最新版のダウンロードURL確認: https://golang.org/dl/
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
```

#### 5. Zellijのインストール
```bash
# WSL内で実行
cargo install --locked zellij
# または
cargo install zellij --locked
```

#### 6. Gemini CLIのインストール
```bash
# WSL内で実行
go install github.com/google/generative-ai-go/cmd/gemini@latest
```

#### 7. Batのインストール
```bash
# WSL内で実行
sudo apt update
sudo apt install -y bat
# batcatコマンドをbatとしてリンク作成
sudo ln -s /usr/bin/batcat /usr/local/bin/bat
```

#### 8. 追加の便利ツール（推奨）
```bash
# WSL内で実行
# jq (JSON処理用)
sudo apt install -y jq

# curl (ダウンロード用)
sudo apt install -y curl

# unzip (ファイル展開用)
sudo apt install -y unzip
```

### APIキーの準備
- Google AI Studio（https://aistudio.google.com/）でGemini APIキーを取得
- 4つの異なるAPIキーを用意（各ペイン用）
- または1つのAPIキーを全ペインで共有（利用制限に注意）

### プロジェクトの配置
```bash
# Git cloneをユーザーのドキュメントフォルダで実施
cd "/c/Users/<ユーザー名>/ドキュメント/"
git clone <リポジトリURL> zellij-gemini
```

### インストール確認コマンド
```bash
# WSL内で実行して各ツールの動作確認
wsl --version              # WSL2が有効か確認
git --version              # Git動作確認
go version                 # Go言語動作確認
cargo --version            # Rust/Cargo動作確認
zellij --version           # Zellij動作確認
gemini --version           # Gemini CLI動作確認
bat --version              # Bat動作確認
```

## 1. 基本的な起動手順

### Step 1: フォルダー移動
```powershell
# PowerShellでプロジェクトディレクトリに移動
cd "C:\Users\<ユーザー名>\ドキュメント\zellij-gemini"
```

### Step 2: WSL立ち上げ
```powershell
# Ubuntu WSLを起動
wsl -d Ubuntu
```

### Step 3: type-04ディレクトリに移動
```bash
# WSL内でtype-04ディレクトリに移動
cd type-04
```

### Step 4: Zellij起動
```bash
# 4分割レイアウトでZellijを起動
zellij --layout layout.kdl
```

### Step 5: Presidentからの指示出し
```bash
# ペインa（President）から各Workerに指示を出す
./ask_flat.sh "あなたの質問をここに入力"
```

## 2. システム構成

### ペイン構成
- **ペインa (President)**: タスク分解・指示出し・結果統合
- **ペインb (Worker B)**: 技術的側面の分析担当
- **ペインc (Worker C)**: 現状動向の分析担当
- **ペインd (Worker D)**: 将来展望の分析担当

### 処理フロー
1. Presidentが質問を受け取り
2. タスクを3つの視点に分解
3. 各Workerに異なるタスクを自動割り当て
4. 各WorkerがGemini AIで分析実行
5. 完了後にPresidentに報告

## 3. メンテナンス・微調整ガイド

### 3.1 役割・指示内容の調整

#### `instructions/a_president.md`
**効果**: Presidentの基本的な役割定義と長文指示の管理

##### 基本的な役割定義の修正例
```markdown
# 修正例：より詳細な指示を追加
## 主要な責務:
1. **タスク分解**: より具体的な分解方法を指定
2. **品質管理**: 各Workerの回答品質をチェック
3. **結果統合**: より高度な統合ロジックを適用
```

##### 長文指示の直書き管理（推奨）
```markdown
## 現在のタスク
新しいAIサービスの市場分析を実施してください

詳細要件:
- 対象市場: 日本国内のBtoB市場
- 分析期間: 2024年1月〜12月
- 重要指標: 市場規模、成長率、競合状況

Worker B: 技術的実装の観点から以下を分析
1. 必要な技術スタック
2. 開発期間の見積もり
3. 技術的リスクの評価

Worker C: 市場動向の観点から以下を分析
1. 競合他社の動向
2. 顧客ニーズの変化  
3. 市場成長の要因

Worker D: ビジネスの観点から以下を分析
1. 収益予測モデル
2. 投資対効果
3. 参入戦略の提案
```

**長文指示の使い方:**
1. `a_president.md`の「現在のタスク」セクションを編集
2. Zellijを再起動して新しい指示を読み込み
3. `ask_flat.sh`で簡単なトリガーコマンドを実行
4. Presidentが詳細指示に基づいてタスク分解を実行

#### `instructions/b_worker.md`, `c_worker.md`, `d_worker.md`
**効果**: 各Workerの専門性を調整
```markdown
# 修正例：Worker Bを技術専門家に特化
# ■ ROLE: TECHNICAL EXPERT WORKER ■
あなたは技術的実装とアーキテクチャの専門家です。
技術仕様、性能、セキュリティの観点から分析してください。
```

### 3.2 起動時の初期化メッセージ

#### `startup_scripts/run_*.sh`
**効果**: 各ペインの初期状態とGemini AIの最初のコンテキスト設定

```bash
# President用（run_a.sh）の修正例
gemini -p "私はPresidentです。システム全体の品質向上を目指し、各Workerからの報告を統合します。"

# Worker用（run_b.sh）の修正例  
gemini -p "私は技術専門Worker Bです。技術的実装と性能に特化した分析を行います。"
```

### 3.3 タスク分解・割り当てロジック

#### `ask_flat.sh`
**効果**: タスクの分解方法と各Workerへの指示内容

```bash
# タスク分解プロンプトのカスタマイズ
TASK_DECOMPOSITION_PROMPT="以下の質問について、より詳細な分析を行うため...
Worker B用: 技術アーキテクチャと実装課題
Worker C用: 市場動向と競合分析  
Worker D用: ビジネスインパクトとROI分析"

# 各Workerへの具体的指示の調整
TASK_B="技術的実装の観点から、アーキテクチャ設計と性能要件を分析..."
```

### 3.4 APIキー管理

#### `startup_scripts/run_*.sh`内のAPIキー設定
**効果**: 各ペインで異なるGemini APIキーを使用
```bash
# 各ペインに異なるAPIキーを設定することで
# - 利用制限の分散
# - 課金の分離
# - 性能の向上
export GEMINI_API_KEY="YOUR_UNIQUE_API_KEY_FOR_PANE_A"
```

### 3.5 レイアウト調整

#### `layout.kdl`
**効果**: ペインの配置とサイズ調整
```kdl
# ペインサイズの調整例
pane size=2 {  // Presidentペインを大きく
    pane command="startup_scripts/run_a.sh" name="a"
}
pane split_direction="horizontal" size=1 {  // Workerペインを横並び
    pane command="startup_scripts/run_b.sh" name="b"
    pane command="startup_scripts/run_c.sh" name="c"
    pane command="startup_scripts/run_d.sh" name="d"
}
```

### 3.6 ペイン間フォーカス移動の調整

#### `ask_flat.sh`内の`focus_pane_and_execute`関数
**効果**: レイアウト変更時のフォーカス移動ロジック調整
```bash
# レイアウトに応じたフォーカス移動の修正
case "$target_pane" in
    "b") zellij action move-focus right ;;      # 横並びレイアウトの場合
    "c") zellij action move-focus right; zellij action move-focus right ;;
    "d") zellij action move-focus down ;;       # 縦並びレイアウトの場合
esac
```

## 4. 高度なカスタマイズ

### 4.1 専門分野特化の設定例

#### AI研究特化バージョン
```bash
# Worker B: アルゴリズム・モデル分析
# Worker C: データセット・学習手法分析  
# Worker D: 実用化・社会実装分析
```

#### ビジネス分析特化バージョン
```bash
# Worker B: 技術的実現可能性
# Worker C: 市場機会分析
# Worker D: 収益性・リスク分析
```

### 4.2 結果出力の改善

#### ログ機能の追加
```bash
# ask_flat.sh内に結果保存機能を追加
echo "=== ANALYSIS RESULTS $(date) ===" >> results.log
echo "Question: $QUESTION" >> results.log
# 各Workerの結果をログファイルに保存
```

### 4.3 エラーハンドリングの強化

```bash
# Geminiコマンドの実行確認
if ! command -v gemini &> /dev/null; then
    echo "Error: Gemini CLI not found. Please install first."
    exit 1
fi

# APIキーの設定確認
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY not set."
    exit 1
fi
```

## 5. トラブルシューティング

### よくある問題と解決方法

1. **Zellijが起動しない**
   - WSLの状態確認: `wsl --list --verbose`
   - Zellijのインストール確認: `which zellij`

2. **ペイン間でコマンドが実行されない**
   - 実行権限の確認: `chmod +x ask_flat.sh startup_scripts/*.sh`
   - レイアウトファイルの構文確認

3. **Gemini APIが応答しない**
   - APIキーの有効性確認
   - ネットワーク接続確認
   - API利用制限の確認

4. **文字化けが発生する**
   - WSLの文字エンコーディング設定確認
   - Zellijの設定ファイル調整

## 6. パフォーマンス最適化

### 6.1 起動時間の短縮
- 必要最小限の初期化プロンプト
- batコマンドの`--paging=never`オプション使用

### 6.2 応答速度の向上
- 各WorkerのGeminiプロンプトを簡潔に
- 不要な`sleep`コマンドの削除

### 6.3 メモリ使用量の最適化
- 大きなファイルの読み込み回避
- ログファイルの定期的なクリーンアップ

---

**注意事項:**
- APIキーは絶対に公開リポジトリにコミットしないでください
- 本番環境では適切なエラーハンドリングを実装してください
- 定期的にシステムの動作確認を行ってください
