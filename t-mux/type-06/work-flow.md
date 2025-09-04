# Type-06 Gemini Squad ワークフロー実践ガイド

## 概要
Type-06は6分割階層レイアウト（大統領→ボス→ワーカー）の中規模構成です。
階層的な指揮系統により、組織的な作業分担と効率的な情報伝達を実現します。

## 🏗️ 階層構造

```
大統領 (A)
    ↓
  ボス (B)
    ↓
ワーカー (C, D, E, F)
```

## 🚀 クイックスタート

### セッション起動
```bash
cd t-mux/type-06
wsl sh tmux_layout.sh
```

### セッション接続
```bash
tmux attach-session -t gemini-squad-6
```

### セッション終了
```bash
tmux kill-session -t gemini-squad-6
```

## 📋 ペイン構成と役割

| ペイン | 役割 | 階層レベル | 主な責務 |
|--------|------|------------|----------|
| 0 | President | L1 | 戦略策定、最終意思決定、全体統括 |
| 1 | Boss | L2 | 戦術実行、チーム管理、進捗統制 |
| 2 | Worker C | L3 | フロントエンド開発、UI/UX |
| 3 | Worker D | L3 | バックエンド開発、API設計 |
| 4 | Worker E | L3 | データベース、インフラ |
| 5 | Worker F | L3 | テスト、品質保証、文書化 |

## 🔧 役割のカスタマイズ

### 1. 階層別役割定義の編集
```bash
# 戦略レベル（L1）
code instructions/a_president.md

# 戦術レベル（L2）
code instructions/b_boss.md

# 実行レベル（L3）
code instructions/c_worker.md
code instructions/d_worker.md
code instructions/e_worker.md
code instructions/f_worker.md
```

### 2. 起動スクリプトの階層別設定
```bash
# 各階層用スクリプトの編集
code startup_scripts_template/run_a.sh  # President
code startup_scripts_template/run_b.sh  # Boss
code startup_scripts_template/run_c.sh  # Worker C
code startup_scripts_template/run_d.sh  # Worker D
code startup_scripts_template/run_e.sh  # Worker E
code startup_scripts_template/run_f.sh  # Worker F
```

### 3. APIキーの設定
```bash
# 環境変数の設定
export GEMINI_API_KEY_TYPE06='your-api-key-here'

# または .env ファイルに追記
echo "GEMINI_API_KEY_TYPE06=your-api-key-here" >> ../../.env
```

## 💬 階層的コミュニケーション

### ツリー型質問（階層順に伝達）
```bash
# President → Boss → Workers の順で伝達
./ask_tree.sh "新しいプロジェクトの要件を検討してください"
```

### フラット型質問（全員に同時配信）
```bash
# 緊急時や全体会議
./ask_flat.sh "緊急：システム障害の対応状況を報告してください"
```

### 階層別個別指示
```bash
# President（戦略レベル）への相談
tmux send-keys -t gemini-squad-6:0.0 "市場戦略の見直しが必要です" Enter

# Boss（戦術レベル）への指示
tmux send-keys -t gemini-squad-6:0.1 "チームの作業分担を調整してください" Enter

# Worker（実行レベル）への具体的タスク
tmux send-keys -t gemini-squad-6:0.2 "ログイン画面のデザインを修正して" Enter
```

## 🛠️ Gemini CLI 階層別運用

### 戦略レベル（President）
```bash
# 高レベルな意思決定
gemini-cli "市場動向を踏まえた事業戦略を提案してください"

# 全体最適化
gemini-cli "プロジェクト全体のリスク評価をお願いします"
```

### 戦術レベル（Boss）
```bash
# チーム管理
gemini-cli "ワーカーの作業負荷を分析して調整案を提示して"

# 進捗管理
gemini-cli "各ワーカーの進捗を統合して報告書を作成して"
```

### 実行レベル（Workers）
```bash
# 専門的な実装
gemini-cli -f "component.jsx" "このReactコンポーネントを最適化して"

# 技術的な問題解決
gemini-cli "データベースのパフォーマンス問題を調査して"
```

## 📊 実務運用パターン

### パターン1: アジャイル開発
1. **President**: プロダクトオーナー、ビジョン策定
2. **Boss**: スクラムマスター、スプリント管理
3. **Worker C**: フロントエンド開発者
4. **Worker D**: バックエンド開発者
5. **Worker E**: DevOpsエンジニア
6. **Worker F**: QAエンジニア

### パターン2: 研究開発
1. **President**: 研究ディレクター、方向性決定
2. **Boss**: プロジェクトマネージャー、リソース調整
3. **Worker C**: データサイエンティスト
4. **Worker D**: アルゴリズム開発者
5. **Worker E**: システム設計者
6. **Worker F**: 評価・検証担当

### パターン3: コンサルティング
1. **President**: パートナー、クライアント対応
2. **Boss**: マネージャー、プロジェクト統括
3. **Worker C**: 業務分析担当
4. **Worker D**: 技術調査担当
5. **Worker E**: 提案書作成担当
6. **Worker F**: 品質管理担当

## 🔄 階層的ワークフロー

### 1. 戦略フェーズ（President主導）
```bash
# 戦略策定
tmux send-keys -t gemini-squad-6:0.0 "プロジェクトの目標と方針を策定" Enter

# ボスへの指示伝達
./ask_tree.sh "以下の戦略に基づいて実行計画を立ててください"
```

### 2. 計画フェーズ（Boss主導）
```bash
# 作業分担の決定
tmux send-keys -t gemini-squad-6:0.1 "ワーカーへのタスク分担を決定" Enter

# ワーカーへの指示
for i in {2..5}; do
    tmux send-keys -t gemini-squad-6:0.$i "担当タスクの詳細計画を作成" Enter
done
```

### 3. 実行フェーズ（Workers主導）
```bash
# 並列作業開始
./ask_flat.sh "各自の担当作業を開始してください"

# 定期的な進捗報告
./ask_tree.sh "現在の進捗状況を階層順に報告してください"
```

### 4. 統合フェーズ（Boss→President）
```bash
# 成果物の統合
tmux send-keys -t gemini-squad-6:0.1 "ワーカーの成果物を統合" Enter

# 最終報告
tmux send-keys -t gemini-squad-6:0.0 "統合結果の最終確認" Enter
```

## 🎯 効率的な階層運用のコツ

### 1. 明確な権限委譲
```bash
# President: 戦略決定権
# Boss: 戦術実行権
# Workers: 専門技術の裁量権
```

### 2. 適切な情報共有
```bash
# 上位層への報告
./ask_tree.sh "重要な進捗や問題を上位に報告"

# 同階層での情報共有
./ask_flat.sh "同じレベルのメンバーと情報共有"
```

### 3. 段階的なエスカレーション
```bash
# Level 1: Worker間で解決
# Level 2: Bossに相談
# Level 3: Presidentに報告
```

## 🚨 階層別トラブルシューティング

### President層の問題
```bash
# 戦略の見直し
tmux send-keys -t gemini-squad-6:0.0 "現在の戦略を再評価" Enter

# 全体調整
./ask_tree.sh "戦略変更に伴う調整を実施"
```

### Boss層の問題
```bash
# チーム調整
tmux send-keys -t gemini-squad-6:0.1 "ワーカー間の調整を実施" Enter

# リソース再配分
./ask_flat.sh "作業負荷の再分散を検討"
```

### Worker層の問題
```bash
# 技術的問題の解決
for i in {2..5}; do
    tmux send-keys -t gemini-squad-6:0.$i "技術的課題の解決策を検討" Enter
done
```

## 📈 パフォーマンス最適化

### 1. 階層間の効率的な連携
- 定期的な階層間ミーティング
- 明確な報告ライン
- 迅速な意思決定プロセス

### 2. 専門性の活用
- 各ワーカーの専門分野を明確化
- 横断的な知識共有
- スキルマトリックスの活用

### 3. 継続的改善
- 定期的なプロセス見直し
- フィードバックループの構築
- ベストプラクティスの共有

## 🔗 関連ファイル

- `tmux_layout.sh`: 階層レイアウト設定
- `ask_tree.sh`: 階層型コミュニケーション
- `ask_flat.sh`: フラット型コミュニケーション
- `instructions/`: 階層別役割定義
- `startup_scripts_template/`: 階層別起動スクリプト

## 📝 階層カスタマイズ例

### 開発組織向け
```bash
# President: CTO
# Boss: 開発マネージャー
# Workers: 各専門開発者
```

### 営業組織向け
```bash
# President: 営業部長
# Boss: チームリーダー
# Workers: 営業担当者
```

### 研究組織向け
```bash
# President: 研究所長
# Boss: プロジェクトリーダー
# Workers: 研究員
```

---

**重要**: 階層構造の利点を最大化するため、各レベルの役割と責任を明確に定義し、
適切な権限委譲と情報共有を心がけてください。