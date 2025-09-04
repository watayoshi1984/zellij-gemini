# Type-04 Gemini Squad ワークフロー実践ガイド

## 概要
Type-04は4分割レイアウト（大統領+3ワーカー）の基本構成です。
シンプルな構造で迅速な意思決定と実行に適しています。

## 🚀 クイックスタート

### セッション起動
```bash
cd t-mux/type-04
wsl sh tmux_layout.sh
```

### セッション接続
```bash
tmux attach-session -t gemini-squad-4
```

### セッション終了
```bash
tmux kill-session -t gemini-squad-4
```

## 📋 ペイン構成と役割

| ペイン | 役割 | 主な責務 |
|--------|------|----------|
| 0 | President | 全体統括、意思決定、方針策定 |
| 1 | Worker B | 技術実装、コード作成 |
| 2 | Worker C | 分析、調査、検証 |
| 3 | Worker D | テスト、品質管理、文書化 |

## 🔧 役割のカスタマイズ

### 1. 役割定義の編集
```bash
# 指示ファイルの編集
code instructions/a_president.md
code instructions/b_worker.md
code instructions/c_worker.md
code instructions/d_worker.md
```

### 2. 起動スクリプトの修正
```bash
# 各ペイン用スクリプトの編集
code startup_scripts_template/run_a.sh
code startup_scripts_template/run_b.sh
code startup_scripts_template/run_c.sh
code startup_scripts_template/run_d.sh
```

### 3. APIキーの設定
```bash
# 環境変数の設定
export GEMINI_API_KEY_TYPE04='your-api-key-here'

# または .env ファイルに追記
echo "GEMINI_API_KEY_TYPE04=your-api-key-here" >> ../../.env
```

## 💬 コミュニケーション方法

### フラット型質問（全員に同時配信）
```bash
./ask_flat.sh "プロジェクトの進捗状況を教えて"
```

### 個別ペインへの指示
```bash
# ペイン1（Worker B）に技術的な質問
tmux send-keys -t gemini-squad-4:0.1 "技術仕様を確認して" Enter

# ペイン2（Worker C）に分析依頼
tmux send-keys -t gemini-squad-4:0.2 "市場動向を調査して" Enter
```

### 簡易ブロードキャスト
```bash
../ask_simple.sh "緊急：優先度の高いタスクに集中してください"
```

## 🛠️ Gemini CLI 運用コマンド

### 基本的な質問
```bash
# 各ペインで実行
gemini-cli "あなたの役割について説明してください"
```

### ファイル解析
```bash
# コードレビュー
gemini-cli -f "path/to/code.py" "このコードの改善点を教えて"

# 文書解析
gemini-cli -f "requirements.txt" "この要件の実装方針を提案して"
```

### 継続的な対話
```bash
# 対話モード開始
gemini-cli --interactive

# 履歴を含む質問
gemini-cli --history "前回の議論を踏まえて次のステップは？"
```

## 📊 実務運用パターン

### パターン1: 開発プロジェクト
1. **President**: 要件定義と全体設計
2. **Worker B**: フロントエンド実装
3. **Worker C**: バックエンド実装
4. **Worker D**: テストとデプロイ

### パターン2: 問題解決
1. **President**: 問題の整理と優先順位付け
2. **Worker B**: 技術的調査
3. **Worker C**: 代替案の検討
4. **Worker D**: 解決策の検証

### パターン3: 文書作成
1. **President**: 構成と方針決定
2. **Worker B**: 技術部分の執筆
3. **Worker C**: 調査とデータ収集
4. **Worker D**: 校正と品質チェック

## 🔄 ワークフロー最適化

### 効率的な作業分担
```bash
# 並列作業の開始
./ask_flat.sh "各自の担当タスクを開始してください"

# 進捗確認
./ask_flat.sh "現在の進捗状況を報告してください"

# 統合作業
./ask_flat.sh "作業結果を統合しましょう"
```

### 品質管理
```bash
# 相互レビュー
tmux send-keys -t gemini-squad-4:0.3 "Worker Bの成果物をレビューして" Enter

# 最終チェック
./ask_flat.sh "最終成果物の品質チェックを実施"
```

## 🚨 トラブルシューティング

### セッションが応答しない場合
```bash
# セッション状態確認
tmux list-sessions

# 強制終了
tmux kill-session -t gemini-squad-4

# 再起動
wsl sh tmux_layout.sh
```

### ペインが正常に動作しない場合
```bash
# ペイン再起動
tmux respawn-pane -t gemini-squad-4:0.1

# 手動でスクリプト実行
tmux send-keys -t gemini-squad-4:0.1 "bash startup_scripts_template/run_b.sh" Enter
```

### APIキーエラーの場合
```bash
# 環境変数確認
echo $GEMINI_API_KEY_TYPE04

# 再設定
export GEMINI_API_KEY_TYPE04='correct-api-key'
source ../../.env
```

## 📈 パフォーマンス向上のコツ

### 1. 明確な役割分担
- 各ワーカーの専門性を活かす
- 重複作業を避ける
- 責任範囲を明確にする

### 2. 効果的なコミュニケーション
- 定期的な進捗共有
- 問題の早期エスカレーション
- 成果物の相互確認

### 3. ツールの活用
- ask_flat.shで全体調整
- 個別指示で詳細作業
- ログ機能で作業履歴管理

## 🔗 関連ファイル

- `tmux_layout.sh`: レイアウト設定
- `ask_flat.sh`: フラット型コミュニケーション
- `instructions/`: 各役割の詳細指示
- `startup_scripts_template/`: 起動スクリプト
- `master-setup.ps1`: PowerShell統合

## 📝 カスタマイズ例

### 開発チーム向け設定
```bash
# President: プロジェクトマネージャー
# Worker B: フロントエンド開発者
# Worker C: バックエンド開発者  
# Worker D: QAエンジニア
```

### 分析チーム向け設定
```bash
# President: 分析リーダー
# Worker B: データサイエンティスト
# Worker C: 市場調査員
# Worker D: レポート作成者
```

---

**注意**: このワークフローは実務経験に基づいて継続的に改善してください。
チームの特性や プロジェクトの要件に応じてカスタマイズすることを推奨します。