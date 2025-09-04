# T-mux: Tmux版 AIエージェント階層協調システム

## 概要

T-muxは、Zellij-Geminiプロジェクトをtmuxベースに移行したバージョンです。
tmuxの強力なセッション管理とペイン分割機能を活用し、複数のAIエージェントが階層的に協調して動作する環境を提供します。

## ディレクトリ構造

```
t-mux/
├── README.md                    # このファイル
├── common/                      # 共通ファイル
│   ├── load_env.sh             # 環境変数読み込み
│   └── tmux_utils.sh           # tmux共通関数
├── type-04/                    # 4分割タイプ
│   ├── instructions/           # エージェント指示書
│   ├── startup_scripts_template/ # 起動スクリプトテンプレート
│   ├── tmux_layout.sh         # tmuxレイアウト設定
│   ├── ask_flat.sh            # フラットタスク実行
│   └── master-setup.ps1       # PowerShell起動スクリプト
├── type-06/                    # 6分割タイプ
│   ├── instructions/
│   ├── startup_scripts_template/
│   ├── tmux_layout.sh
│   ├── ask_tree.sh
│   └── master-setup.ps1
├── type-08/                    # 8分割タイプ
│   ├── instructions/
│   ├── startup_scripts_template/
│   ├── tmux_layout.sh
│   ├── ask_tree.sh
│   └── master-setup.ps1
└── type-16/                    # 16分割タイプ
    ├── instructions/
    ├── startup_scripts_template/
    ├── tmux_layout.sh
    ├── ask_tree.sh
    └── master-setup.ps1
```

## 主な変更点

### Zellijからtmuxへの移行

1. **レイアウト設定**
   - Zellij: `.kdl`または`.yaml`ファイル
   - Tmux: シェルスクリプトでのペイン作成・分割

2. **ペイン間通信**
   - Zellij: `zellij action`コマンド
   - Tmux: `tmux send-keys`コマンド

3. **セッション管理**
   - Zellij: 自動セッション管理
   - Tmux: 明示的なセッション作成・アタッチ

## 使用方法

### 基本的な起動手順

1. PowerShellでプロジェクトディレクトリに移動
```powershell
cd "C:\Users\<ユーザー名>\ドキュメント\zellij-gemini\t-mux"
```

2. 希望するタイプのディレクトリに移動して起動
```powershell
cd type-04
.\master-setup.ps1
```

3. WSL内でtmuxセッションにアタッチ
```bash
tmux attach-session -t gemini-squad
```

## 技術仕様

- **ベースシステム**: tmux 3.0以上
- **OS要件**: WSL2 (Ubuntu推奨)
- **AI CLI**: Gemini CLI / Claude CLI
- **シェル**: Bash
- **起動環境**: PowerShell 5.1以上

## ライセンス

MITライセンス（元プロジェクトと同様）