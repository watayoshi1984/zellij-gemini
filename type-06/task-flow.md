# Zellij-Gemini 階層AI協調システム (6分割) 操作ガイド

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

### APIキーの準備
- Google AI Studio（https://aistudio.google.com/）でGemini APIキーを取得
- 6つの異なるAPIキーを用意（各ペイン用）
- または共通APIキーを使用（利用制限に注意）

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

### Step 3: type-06ディレクトリに移動
```bash
# WSL内でtype-06ディレクトリに移動
cd type-06
```

### Step 4: Zellij起動
```bash
# 6分割階層レイアウトでZellijを起動
zellij --layout layout.yaml
```

### Step 5: Presidentからの階層指示出し
```bash
# ペインa（President）から階層的に指示を出す
./ask_tree.sh "あなたの質問をここに入力"
```

## 2. システム構成（階層構造）

### ペイン構成
- **ペインa (President)**: 最高意思決定・全体統括・最終結論
- **ペインb (Boss)**: 中間管理・Worker統括・報告統合
- **ペインc (Worker C)**: 技術専門（実装・アーキテクチャ・性能）
- **ペインd (Worker D)**: 市場専門（動向・競合・顧客ニーズ）
- **ペインe (Worker E)**: 戦略専門（将来展望・事業戦略・成長）
- **ペインf (Worker F)**: リスク専門（課題・リスク・対策案）

### 階層処理フロー
1. **President**: 質問を受け取り、階層的なタスク分解を実行
2. **Boss委任**: Bossに各Workerの統括と統合報告を指示
3. **Worker実行**: Boss指示に基づき各Workerが専門分析を実施
4. **Boss統合**: Workerからの報告を統合し、Presidentに総合報告
5. **President決定**: Boss報告を基に最終的な意思決定を実行

## 3. メンテナンス・微調整ガイド

### 3.1 階層構造の調整

#### `instructions/a_president.md`
**効果**: Presidentの最高意思決定権限と階層統括能力の定義

##### 基本的な役割定義の修正例
```markdown
## 主要な責務:
1. **階層的タスク分解**: より戦略的な分解方法を指定
2. **Boss管理**: 中間管理層の統括と品質管理
3. **最終意思決定**: 総合的な判断基準と決定プロセス
```

##### 長文指示の直書き管理（推奨）
```markdown
## 現在のプロジェクト
新規事業計画の包括的分析

プロジェクト概要:
- 事業領域: AIを活用したヘルスケアサービス
- ターゲット: 高齢者向け在宅医療支援
- 期間: 6ヶ月間の詳細検討
- 予算: 初期投資500万円

Boss B指示内容:
各Workerから以下の専門分析を取得し、統合レポートを作成

Worker C (技術): AIアルゴリズム選定、システム構成、開発工数
Worker D (市場): 競合分析、市場規模、顧客ニーズ調査
Worker E (戦略): 事業展開計画、収益モデル、成長戦略
Worker F (リスク): 技術リスク、事業リスク、対策案

最終的な投資判断のための包括的提言を求めます。
```

#### `instructions/b_boss.md`
**効果**: Boss の中間管理能力と統合報告機能の強化
```markdown
## 配下Worker管理:
- Worker配分の最適化
- 作業進捗の監視
- 品質管理とレビュー
- 統合分析の実施

## 統合報告プロセス:
1. 各Worker報告の収集と整理
2. 矛盾点や不整合の確認と調整
3. 包括的な分析とまとめ
4. President向け戦略的提言の作成
```

### 3.2 Worker専門性の調整

#### `instructions/c_worker.md`, `d_worker.md`, `e_worker.md`, `f_worker.md`
**効果**: 各Workerの専門分野特化

```markdown
# Worker C (技術専門家)の例
# ■ ROLE: TECHNICAL EXPERT WORKER ■
あなたは技術的実装とアーキテクチャの専門家です。
- システム設計と実装方針
- 技術的実現可能性の評価
- 性能・セキュリティ・拡張性の分析
- 技術リスクと対策案の提案

# Worker D (市場専門家)の例  
# ■ ROLE: MARKET ANALYST WORKER ■
あなたは市場動向と競合分析の専門家です。
- 市場規模と成長予測
- 競合他社の戦略分析
- 顧客ニーズと市場機会の特定
- 市場参入戦略の提案
```

### 3.3 起動時の初期化メッセージ

#### `startup_scripts/run_*.sh`
**効果**: 各ペインの階層意識と専門性の初期設定

```bash
# President用（run_a.sh）の修正例
gemini -p "私は最高責任者Presidentです。Boss Bを統括し、戦略的な意思決定を行います。"

# Boss用（run_b.sh）の修正例  
gemini -p "私は中間管理者Bossです。Worker C-Fを統括し、統合分析をPresidentに報告します。"

# Worker用（run_c.sh）の修正例
gemini -p "私は技術専門Worker Cです。Bossの指示で技術分析を行い、正確な報告を提出します。"
```

### 3.4 階層タスク分解ロジック

#### `ask_tree.sh`
**効果**: 階層的な指示系統と専門分野連携の最適化

```bash
# 階層分解プロンプトのカスタマイズ
TASK_DECOMPOSITION_PROMPT="以下の質問について、経営層・管理層・専門層の階層構造で分析...
President: 戦略的意思決定と最終承認
Boss B: 各専門領域の統括と統合分析
Worker C: 技術実装の詳細検討
Worker D: 市場機会の精密分析
Worker E: 事業戦略の具体化
Worker F: リスク評価と対策立案"

# Boss指示内容の詳細化
BOSS_TASK="各Workerの専門性を活かした効率的な分担を行い...
技術・市場・戦略・リスクの4軸で包括的に分析し、
統合的な提言をPresidentに提出してください。"
```

### 3.5 レイアウト調整

#### `layout.yaml`
**効果**: 階層を視覚的に表現するペイン配置

```yaml
# 階層構造を反映したレイアウト例
session_name: "gemini-hierarchy-6"
tabs:
  - name: "Management Control"
    layout:
      direction: Vertical
      parts:
        - name: "a"  # President (最上層)
          command: "startup_scripts/run_a.sh"
          size: 2
        - name: "b"  # Boss (中間層)  
          command: "startup_scripts/run_b.sh"
          size: 1
        - direction: Horizontal  # Workers (専門層)
          parts:
            - name: "c"
              command: "startup_scripts/run_c.sh"
            - name: "d"
              command: "startup_scripts/run_d.sh"
            - name: "e"
              command: "startup_scripts/run_e.sh"
            - name: "f"
              command: "startup_scripts/run_f.sh"
```

### 3.6 ペイン間フォーカス移動の調整

#### `ask_tree.sh`内の`focus_pane_and_execute`関数
**効果**: 6分割レイアウトに最適化された移動ロジック
```bash
# 6分割レイアウト用フォーカス移動
case "$target_pane" in
    "b") zellij action move-focus down ;;                    # President → Boss
    "c") zellij action move-focus down; zellij action move-focus down ;;  # President → Worker C
    "d") zellij action move-focus down; zellij action move-focus down; zellij action move-focus right ;;  # President → Worker D
    # 以下、Worker E, Fへの移動...
esac
```

## 4. 高度なカスタマイズ

### 4.1 業界特化型設定例

#### コンサルティング特化バージョン
```bash
# Worker C: 業務プロセス分析・改善提案
# Worker D: 市場・競合・ベンチマーク分析
# Worker E: 戦略立案・ロードマップ作成
# Worker F: 実行計画・リスク管理
```

#### 技術開発特化バージョン
```bash
# Worker C: アーキテクチャ設計・技術選定
# Worker D: 要件分析・ユーザビリティ検討
# Worker E: 開発計画・プロジェクト管理
# Worker F: 品質管理・セキュリティ対策
```

### 4.2 階層コミュニケーション強化

#### Boss-Worker間の定期報告機能
```bash
# ask_tree.sh内に進捗確認機能を追加
check_worker_progress() {
    echo "=== Boss B による Worker 進捗確認 ==="
    for worker in c d e f; do
        focus_pane_and_execute "$worker" "echo '進捗状況を報告してください'"
    done
}
```

#### President-Boss間の戦略会議機能
```bash
# 定期的な戦略レビュー
strategic_review() {
    focus_pane_and_execute "b" "gemini -p '現在の分析状況をPresidentに中間報告してください'"
}
```

### 4.3 結果出力の改善

#### 階層別ログ機能
```bash
# ask_tree.sh内に階層別ログ保存
echo "=== HIERARCHICAL ANALYSIS RESULTS $(date) ===" >> hierarchy_results.log
echo "President Decision: $QUESTION" >> hierarchy_results.log
echo "Boss Integration: [Boss統合結果]" >> hierarchy_results.log
echo "Worker Reports:" >> hierarchy_results.log
# 各Workerの結果をログ保存
```

## 5. トラブルシューティング

### 階層構造特有の問題と解決方法

1. **Boss-Worker間の指示伝達失敗**
   - Boss指示の明確化
   - Worker専門性の再定義
   - 中間報告プロセスの導入

2. **階層レベルでの権限混乱**
   - 各階層の責任範囲を明確化
   - 指示系統の可視化
   - エスカレーション・ルールの設定

3. **統合報告の品質低下**
   - Boss統合能力の強化
   - Worker報告フォーマットの統一
   - 品質チェックプロセスの導入

4. **階層間コミュニケーション遅延**
   - 報告タイミングの最適化
   - 中間確認プロセスの簡素化
   - 並行処理の導入

## 6. パフォーマンス最適化

### 6.1 階層実行効率の向上
- Boss指示の並列化
- Worker作業の同期実行
- 中間報告の簡潔化

### 6.2 統合処理の高速化
- 報告フォーマットの標準化
- 自動集約機能の導入
- リアルタイム進捗表示

### 6.3 意思決定プロセスの最適化
- 判断基準の明確化
- 段階的承認プロセス
- 例外処理の自動化

---

**階層AI協調システムの特徴:**
- 企業組織のような階層構造でAI連携を実現
- 専門性の分離と統合による高品質な分析
- 効率的な意思決定プロセス
- スケーラブルな組織運営モデル

**注意事項:**
- 階層構造は明確な指示系統を維持してください
- 各階層の責任範囲を混同しないよう注意してください
- 定期的な階層効率の見直しを実施してください
