# Tmux Gemini Squad Setup Guide

## 概要

Tmux Gemini Squadは、複数のAIエージェントが協調して作業を行うためのTmux環境です。
異なる専門性を持つエージェントが各ペインで動作し、効率的な問題解決を実現します。

## 利用可能なレイアウト

### Type-04 (4ペインレイアウト)
- **President** (ペイン0): 全体統括・意思決定
- **Technical** (ペイン1): 技術的分析
- **Business** (ペイン2): ビジネス分析
- **Quality** (ペイン3): 品質保証・検証

### Type-06 (6ペインレイアウト)
- **President** (ペイン0): 全体統括・意思決定
- **Technical** (ペイン1): 技術的分析
- **Business** (ペイン2): ビジネス分析
- **Quality** (ペイン3): 品質保証・検証
- **Market** (ペイン4): 市場分析
- **Strategy** (ペイン5): 戦略立案

### Type-08 (8ペインレイアウト)
- **President** (ペイン0): 全体統括・意思決定
- **Technical Boss** (ペイン1): 技術部門統括
- **System Design** (ペイン2): システム設計
- **Implementation** (ペイン3): 実装・開発
- **Quality Assurance** (ペイン4): 品質保証
- **Business Boss** (ペイン5): ビジネス部門統括
- **Market Analysis** (ペイン6): 市場分析
- **Business Strategy** (ペイン7): ビジネス戦略

### Type-16 (16ペインレイアウト)
企業レベルの包括的分析環境
- **President** (ペイン0): 最高責任者
- **Technical Division** (ペイン1-7): 技術部門
- **Business Division** (ペイン8-15): ビジネス部門

## セットアップ手順

### 1. 前提条件
- Windows 10/11 with WSL2
- Tmux がインストールされていること
- Gemini API キーまたは Claude API キー

### 2. 初期セットアップ

#### Windows PowerShellから開始
```powershell
# t-muxディレクトリに移動
cd "C:\path\to\zellij-gemini\t-mux"

# マスターセットアップスクリプトを実行
.\master-setup.ps1
```

#### WSL内でのセットアップ
```bash
# 特定のレイアウトディレクトリに移動
cd type-04  # または type-06, type-08, type-16

# そのレイアウト用のセットアップを実行
./master-setup.ps1
```

### 3. APIキーの設定

各レイアウトディレクトリの `startup_scripts_template/run_*.sh` ファイルでAPIキーを設定:

```bash
# Gemini APIキーの場合
export GEMINI_API_KEY_TYPE04="your-gemini-api-key-here"

# Claude APIキーの場合
export CLAUDE_API_KEY="your-claude-api-key-here"
```

## 使用方法

### セッションの開始
```bash
# 共通起動スクリプトを使用
./start_tmux_session.sh 04  # type-04を起動
./start_tmux_session.sh 16  # type-16を起動

# または直接レイアウトスクリプトを実行
cd type-04
./tmux_layout.sh
```

### セッションへの接続
```bash
# セッションにアタッチ
tmux attach-session -t gemini-squad-04
tmux attach-session -t gemini-squad-16

# セッション一覧を確認
tmux list-sessions
```

### 質問・タスクの実行

#### 1. ask_simple.sh - 全ペインへのブロードキャスト
```bash
./ask_simple.sh "市場分析を行ってください"
```

#### 2. ask_flat.sh - フラット階層での直接指示
```bash
./ask_flat.sh "新製品の技術仕様を検討してください"
```

#### 3. ask_tree.sh - 階層的な委任（type-08, type-16で利用可能）
```bash
./ask_tree.sh "企業戦略の包括的分析を実施してください"
```

### ペイン間のナビゲーション

```bash
# 基本的なTmuxコマンド
Ctrl-b + 矢印キー    # ペイン間移動
Ctrl-b + q          # ペイン番号表示
Ctrl-b + z          # ペインのズーム切り替え
Ctrl-b + d          # セッションからデタッチ
```

## ディレクトリ構造

```
t-mux/
├── master-setup.ps1           # Windows用メインセットアップ
├── start_tmux_session.sh      # 共通起動スクリプト
├── ask_common.sh              # 共通ユーティリティ関数
├── load_env.sh                # 環境設定読み込み
├── session_manager.sh         # セッション管理
├── start_gemini_squad.sh      # Gemini Squad起動
├── ask_simple.sh              # シンプルブロードキャスト
├── type-04/                   # 4ペインレイアウト
│   ├── master-setup.ps1
│   ├── tmux_layout.sh
│   ├── ask_flat.sh
│   └── startup_scripts_template/
├── type-06/                   # 6ペインレイアウト
│   ├── master-setup.ps1
│   ├── tmux_layout.sh
│   ├── ask_flat.sh
│   └── startup_scripts_template/
├── type-08/                   # 8ペインレイアウト
│   ├── master-setup.ps1
│   ├── tmux_layout.sh
│   ├── ask_flat.sh
│   ├── ask_tree.sh
│   └── startup_scripts_template/
└── type-16/                   # 16ペインレイアウト
    ├── master-setup.ps1
    ├── tmux_layout.sh
    ├── ask_flat.sh
    ├── ask_tree.sh
    └── startup_scripts_template/
```

## トラブルシューティング

### よくある問題

1. **Tmuxが見つからない**
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install tmux
   
   # CentOS/RHEL
   sudo yum install tmux
   ```

2. **APIキーが設定されていない**
   - `startup_scripts_template/run_*.sh` ファイルでAPIキーを確認
   - 環境変数が正しく設定されているか確認

3. **セッションが既に存在する**
   ```bash
   # 既存セッションを終了
   tmux kill-session -t gemini-squad-04
   
   # または既存セッションにアタッチ
   tmux attach-session -t gemini-squad-04
   ```

4. **スクリプトに実行権限がない**
   ```bash
   chmod +x *.sh
   chmod +x startup_scripts_template/*.sh
   ```

### ログの確認

```bash
# セッションログの確認
tail -f ~/.tmux_session.log

# 個別ペインのログ確認
# 各ペインで実行されているコマンドの出力を確認
```

## 高度な使用方法

### カスタムレイアウトの作成

1. 新しいtypeディレクトリを作成
2. `tmux_layout.sh` を作成してペイン構成を定義
3. `ask_flat.sh` と `ask_tree.sh` を作成
4. `startup_scripts_template/` ディレクトリに起動スクリプトを配置

### 複数セッションの同時実行

```bash
# 異なるレイアウトを同時に実行
./start_tmux_session.sh 04
./start_tmux_session.sh 16

# セッション間の切り替え
tmux switch-client -t gemini-squad-04
tmux switch-client -t gemini-squad-16
```

## 参考資料

- [Tmux公式ドキュメント](https://github.com/tmux/tmux/wiki)
- [Gemini API ドキュメント](https://ai.google.dev/docs)
- [Claude API ドキュメント](https://docs.anthropic.com/)

---

**注意**: このシステムは開発・実験用途を想定しています。本番環境での使用前に十分なテストを行ってください。