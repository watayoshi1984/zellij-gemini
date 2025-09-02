# Zellij-Gemini: AIエージェントによる階層的タスク実行環境

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 概要

Zellij-Geminiは、Zellijをベースとしたマルチペインターミナル環境で、複数のGemini AIエージェントまたはClaude Code AIエージェントが階層的に協調して動作するプロジェクトです。各エージェントは独自の役割（President, Boss, Worker）とAPIキーを持ち、上位エージェントが下位エージェントにタスクを委譲し、結果を収集・集約することで、複雑な処理を分散・並列に実行します。

この環境は、AIを用いた大規模な情報収集・分析・レポート作成など、人手では困難な作業を効率化・自動化することを目的としています。

## 使用技術

このプロジェクトは、以下の技術・ツールを活用しています。

### 1. **Zellij**
- **概要:** Zellijは、Linux/macOS/WSL向けの強力なターミナルマルチプレクサです。tmuxに似ていますが、よりモダンで使いやすいインターフェースを提供します。
- **本プロジェクトでの役割:**
  - 複数のターミナルセッション（ペイン）を1つのウィンドウで管理します。
  - 各ペインに独立したAIエージェントを配置し、並列処理を実現します。
  - レイアウトファイル（`layout.yaml`）により、起動時に複雑なペイン構成を自動で構築します。
  - `zellij action`コマンドを用いて、ペイン間のコマンド送信や操作をスクリプト化できます。

### 2. **Google AI CLI (`gemini`)**
- **概要:** Googleが提供するGeminiモデルのコマンドラインインターフェースツールです。APIキーを設定することで、ターミナルから直接Geminiモデルと対話できます。
- **本プロジェクトでの役割:**
  - 各ペイン（AIエージェント）が、自身のAPIキーを使ってGeminiモデルに質問や指示を送信します。
  - Workerペインは主にこのCLIを介してタスクを実行します。
  - `gemini chat`コマンドが主な実行手段です。

### 2. **Claude Code CLI (`claude`)**
- **概要:** Anthropicが提供するClaude Codeモデルのコマンドラインインターフェースツールです。APIキーを設定することで、ターミナルから直接Claude Codeモデルと対話できます。
- **本プロジェクトでの役割:**
  - 各ペイン（AIエージェント）が、自身のAPIキーを使ってClaude Codeモデルに質問や指示を送信します。
  - Workerペインは主にこのCLIを介してタスクを実行します。
  - `claude -p`コマンドが主な実行手段です。

### 3. **WSL (Windows Subsystem for Linux)**
- **概要:** Windows上でLinux環境を実行できる互換レイヤーです。
- **本プロジェクトでの役割:**
  - ZellijとAI CLIがLinux環境で動作するため、Windowsユーザーでも簡単に利用できるようにします。
  - PowerShellスクリプト（`master-setup.ps1`）からWSLを起動し、プロジェクト環境を構築します。

### 4. **PowerShell**
- **概要:** Windowsのタスク自動化と構成管理のためのコマンドラインシェルおよびスクリプト言語です。
- **本プロジェクトでの役割:**
  - プロジェクトのセットアップと起動を簡単にするためのエントリーポイントスクリプト（`master-setup.ps1`）を提供します。
  - WSLパスの変換や、Zellijの起動コマンドを実行します。

### 5. **Bash**
- **概要:** Unix系オペレーティングシステムの標準シェルの一つです。
- **本プロジェクトでの役割:**
  - 各ペインの起動スクリプト（`run_*.sh`）や、階層的タスク実行スクリプト（`ask_tree.sh`, `ask_flat.sh`）で使用されます。
  - エージェント間の通信（`zquery`関数）や、AI CLIの実行に使用されます。

### 6. **`bat`**
- **概要:** `cat`コマンドの現代的な代替で、シンタックスハイライトとGitとの統合機能を備えています。
- **本プロジェクトでの役割:**
  - 各ペイン起動時に、そのエージェントの役割が記述された指示書（`instructions/*.md`）を美しく表示するために使用されます。

## 実現できること

Zellij-Geminiプロジェクトは、以下のような高度な機能を実現します。

### 1. **階層的AIエージェント構造**
- **16分割、8分割、6分割、4分割**の4つの異なる構成で、AIエージェントを配置できます。
- **President (a):** 最上位のエージェント。全体のタスクを管理し、最終的な判断を下します。
- **Boss (b, c, d...):** 中間管理エージェント。Presidentからタスクを受け取り、それをWorkerにさらに細分化して委譲します。
- **Worker (e, f, g...):** 実行エージェント。具体的なタスク（AIへの質問など）を実行し、結果を上位に報告します。

### 2. **並列・分散タスク実行**
- 複数のWorkerが同時に異なる質問やタスクを処理できるため、処理時間を大幅に短縮できます。
- 例: "最新のAI技術の動向について調査してください"というタスクを、各Workerが異なる視点や情報源で並行して調査し、Bossがその結果を集約します。

### 3. **エージェント間通信と制御**
- `ask_tree.sh`や`ask_flat.sh`スクリプトにより、上位エージェント（PresidentやBoss）から下位エージェントに直接コマンドを送信できます。
- `zquery`という独自のBash関数が、Zellijの`action`コマンドをラップし、他のペインでコマンドを実行し、その結果を取得する機能を提供します。
- これにより、エージェント間の協調的なワークフローが可能になります。

### 4. **柔軟なカスタマイズ性**
- 各ペインの指示書（`instructions/*.md`）を編集することで、エージェントの役割や振る舞いを細かくカスタマイズできます。
- 各起動スクリプト（`startup_scripts/run_*.sh`）で、エージェントごとに異なるAPIキーを設定できます。これにより、例えば特定のWorkerに高機能なモデルのAPIキーを割り当てたり、コスト管理のために一部のWorkerに軽量モデルを使用させたりできます。

### 5. **ワンクリック起動**
- `master-setup.ps1`を実行するだけで、WSLが起動し、Zellijが指定されたレイアウトで起動し、すべてのエージェントがそれぞれの役割を読み込んだ状態で準備完了になります。

## どのように活用できるのか

Zellij-Geminiは、以下のようなシナリオで強力なツールとして活用できます。

### 1. **複雑な調査・分析レポートの自動生成**
- **シナリオ:** "当社の新サービスに対する競合分析レポートを作成してください"というタスクをPresidentが発行。
- **プロセス:**
  1. PresidentがBossにタスクを委譲。
  2. BossがWorker達に、"競合Aの特徴", "競合Bの価格戦略", "競合Cのユーザー評価"など、具体的なサブタスクを分配。
  3. 各WorkerがAIに質問し、情報を収集。
  4. Workerの結果がBossに報告され、Bossがそれを統合。
  5. Bossの報告がPresidentに届き、Presidentが最終的なレポートを構成。
- **効果:** 人手では数時間〜数日かかる作業を、数分で自動化できます。

### 2. **多角的なアイデア出し・ブレインストーム**
- **シナリオ:** "新商品のネーミングとコンセプトを考えてください"。
- **プロセス:**
  1. Presidentが、"ターゲット層別のネーミング", "機能別のコンセプト", "季節感を考慮したバリエーション"などのタスクをBossに分配。
  2. 各BossがWorker達に更に細分化された指示（例: "20代女性向けのカジュアルなネーミング5つ")を出し、並列でアイデアを収集。
  3. 収集されたアイデアが階層的に集約され、多角的で豊富なアイデアプールが生成される。
- **効果:** 限られた視点からのブレインストームに比べ、より多様で創造的なアイデアが得られます。

### 3. **コードレビュー・テストの並列実行**
- **シナリオ:** 大規模なコードベースのレビューとテスト。
- **プロセス:**
  1. Presidentが、"セキュリティ観点からのレビュー", "パフォーマンス観点からのレビュー", "機能テスト", "エッジケーステスト"などのタスクをBossに分配。
  2. 各BossがWorker達に具体的なファイルやテストケースを割り当て、AIにコードを分析させたり、テストコードを生成・実行させたりします。
  3. 結果を集約することで、人的リソースをかけずに広範囲の品質保証が可能です。
- **効果:** 開発スピードの向上と、品質の安定化。

### 4. **学習・教育支援**
- **シナリオ:** 複雑なトピックの学習。
- **プロセス:**
  1. Presidentが、"このトピックの概要", "歴史的背景", "主要な理論", "実用例"などのサブタスクをBossに分配。
  2. 各BossがWorkerに更に細分化されたテーマを割り当て、並行して学習資料の収集や要約を実施。
  3. 集約された情報をもとに、ユーザーに分かりやすい形でトピック全体の理解を深めることができます。
- **効果:** 効率的で体系的な学習が可能になります。

## はじめに

### 前提条件

プロジェクトを実行するには、以下のソフトウェアがインストールされている必要があります。

- **Windows:**
  - PowerShell
  - WSL2 (Windows Subsystem for Linux)
    - Linuxディストリビューション (例: Ubuntu)
- **WSL (Ubuntu) 内:**
  - **Zellij:** `cargo install --locked zellij`
  - **Gemini CLI:** `go install github.com/google/generative-ai-go/cmd/gemini@latest`
  - **Claude Code CLI:** `curl -fsSL https://downloads.anthropic.com/claude/code/latest/linux | sh`
  - **bat:** `sudo apt update && sudo apt install -y bat && [ ! -f /usr/local/bin/bat ] && sudo ln -s /usr/bin/batcat /usr/local/bin/bat`

### PowerShell実行ポリシーの設定

PowerShellでスクリプトを実行するには、実行ポリシーの設定が必要な場合があります。

1. 管理者権限でPowerShellを開きます。
2. 以下のコマンドを実行して、実行ポリシーを変更します。
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```
3. プロンプトに従って、ポリシーの変更を確認します（通常は「Y」を入力）。

### セットアップ手順 (Gemini CLI)

1. **リポジトリのクローン:**
   ```bash
   git clone https://github.com/watayoshi1984/zellij-gemini.git
   cd zellij-gemini
   ```

2. **APIキーの設定:**
   - プロジェクトルートに.env.sampleファイルがあります。このファイルを.envにコピーしてください。
   - `.env`ファイルに実際のAPIキーを設定してください。
   - 各分割タイプ（`type-16`, `type-08`, `type-06`, `type-04`）のAPIキー用にプレースホルダーが用意されています。
   - 例: `.env`ファイル内の`GEMINI_API_KEY_A=YOUR_GEMINI_API_KEY_FOR_A`を`GEMINI_API_KEY_A=AIzaSyA*******************`のように変更します。

3. **環境の起動:**
   - Windowsのエクスプローラーで、使用したい分割タイプのフォルダ（例: `type-16`）を開きます。
   - `master-setup.ps1`ファイルを右クリックし、「PowerShellで実行」を選択します。
   - WSLターミナルが開き、Zellijが指定されたレイアウトで起動します。
   - 各ペインで`q`キーを押すと、指示書のビューワーが終了し、コマンドプロンプトが表示されます。

### セットアップ手順 (Claude Code CLI)

1. **リポジトリのクローン:**
   ```bash
   git clone https://github.com/watayoshi1984/zellij-gemini.git
   cd zellij-gemini
   ```

2. **Claude Code CLIのインストール:**
   - WSL内で以下のコマンドを実行します:
     ```bash
     curl -fsSL https://downloads.anthropic.com/claude/code/latest/linux | sh
     ```

3. **APIキーの設定:**
   - プロジェクトルートに.env.sampleファイルがあります。このファイルを.envにコピーしてください。
   - `.env`ファイルに実際のAPIキーを設定してください。
   - 各分割タイプ（`type-16`, `type-08`, `type-06`, `type-04`）のAPIキー用にプレースホルダーが用意されています。
   - 例: `.env`ファイル内の`CLAUDE_API_KEY_A=YOUR_CLAUDE_API_KEY_FOR_A`を`CLAUDE_API_KEY_A=sk-ant-*******************`のように変更します。

4. **環境の起動:**
   - Windowsのエクスプローラーで、使用したい分割タイプのフォルダ（例: `type-16`）を開きます。
   - `master-setup.ps1`ファイルを右クリックし、「PowerShellで実行」を選択します。
   - WSLターミナルが開き、Zellijが指定されたレイアウトで起動します。
   - 各ペインで`q`キーを押すと、指示書のビューワーが終了し、コマンドプロンプトが表示されます。

### 基本的な使い方

1. **タスクの実行:**
   - Zellijのペイン'a'（President）に移動します。
   - 以下のコマンドを実行して、階層的なタスクを開始します。
     - 16分割, 8分割, 6分割タイプの場合:
       ```bash
       ./ask_tree.sh "あなたのタスク内容"
       ```
     - 4分割タイプの場合:
       ```bash
       ./ask_flat.sh "あなたのタスク内容"
       ```
   - 例: `./ask_tree.sh "最新のAI技術の動向について教えてください。"`

2. **結果の確認:**
   - ペイン'a'の画面に、各Workerからの応答が順番に表示されます。
   - 上位のBossやPresidentがどのように結果を集約したかも確認できます。

## プロジェクト構造

```
zellij-gemini/
├── type-16/                 # 16分割タイプのプロジェクト
│   ├── instructions/        # 各エージェントの指示書
│   ├── startup_scripts/     # 各ペインの起動スクリプト (Git管理対象外)
│   ├── startup_scripts_template/ # 各ペインの起動スクリプトテンプレート
│   ├── layout.yaml          # Zellijレイアウト定義
│   ├── ask_tree.sh          # 階層的タスク実行スクリプト
│   └── master-setup.ps1     # PowerShell起動スクリプト
│
├── type-08/                 # 8分割タイプのプロジェクト
│   ├── instructions/
│   ├── startup_scripts/     # 各ペインの起動スクリプト (Git管理対象外)
│   ├── startup_scripts_template/ # 各ペインの起動スクリプトテンプレート
│   ├── layout.yaml
│   ├── ask_tree.sh
│   └── master-setup.ps1
│
├── type-06/                 # 6分割タイプのプロジェクト
│   ├── instructions/
│   ├── startup_scripts/     # 各ペインの起動スクリプト (Git管理対象外)
│   ├── startup_scripts_template/ # 各ペインの起動スクリプトテンプレート
│   ├── layout.yaml
│   ├── ask_tree.sh
│   └── master-setup.ps1
│
├── type-04/                 # 4分割タイプのプロジェクト
│   ├── instructions/
│   ├── startup_scripts/     # 各ペインの起動スクリプト (Git管理対象外)
│   ├── startup_scripts_template/ # 各ペインの起動スクリプトテンプレート
│   ├── layout.kdl           # Zellijレイアウト定義
│   ├── ask_flat.sh          # フラットなタスク実行スクリプト
│   └── master-setup.ps1
│
├── setup.md                 # 初期構築手順書
├── install_claude.sh        # Claude Code CLIインストールスクリプト
├── run_claude.sh            # Claude Code起動スクリプト
└── README.md                # 本ファイル
```

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は[LICENSE](file:zellij-gemini\LICENSE)ファイルをご参照ください。