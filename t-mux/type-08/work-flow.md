# Type-08 Gemini Squad ワークフロー実践ガイド

## 概要
Type-08は8分割複合階層レイアウトの大規模構成です。
マネージャー→リーダー→スペシャリストの3層構造により、
複雑なプロジェクトの効率的な管理と専門性の活用を実現します。

## 🏗️ 複合階層構造

```
    Manager (A)
        ↓
  ┌─────┼─────┐
Leader B  Leader C  Leader D
  ↓       ↓       ↓
Spec E   Spec F   Spec G   Spec H
```

## 🚀 クイックスタート

### セッション起動
```bash
cd t-mux/type-08
wsl sh tmux_layout.sh
```

### セッション接続
```bash
tmux attach-session -t gemini-squad-8
```

### セッション終了
```bash
tmux kill-session -t gemini-squad-8
```

## 📋 複合階層ペイン構成

| ペイン | 役割 | 階層 | チーム | 主な責務 |
|--------|------|------|--------|----------|
| 0 | Manager A | L1 | 統括 | 全体戦略、意思決定、リソース配分 |
| 1 | Leader B | L2 | Team-1 | フロントエンド統括、UI/UX戦略 |
| 2 | Leader C | L2 | Team-2 | バックエンド統括、アーキテクチャ |
| 3 | Leader D | L2 | Team-3 | インフラ統括、運用戦略 |
| 4 | Specialist E | L3 | Team-1 | React/Vue開発、コンポーネント設計 |
| 5 | Specialist F | L3 | Team-2 | API開発、データベース設計 |
| 6 | Specialist G | L3 | Team-3 | DevOps、CI/CD、監視 |
| 7 | Specialist H | L3 | 横断 | QA、テスト自動化、品質保証 |

## 🔧 複合階層の役割カスタマイズ

### 1. 階層別役割定義の編集
```bash
# 戦略層（L1）
code instructions/a_manager.md

# 戦術層（L2）
code instructions/b_leader.md
code instructions/c_leader.md
code instructions/d_leader.md

# 実行層（L3）
code instructions/e_specialist.md
code instructions/f_specialist.md
code instructions/g_specialist.md
code instructions/h_specialist.md
```

### 2. チーム別起動スクリプト設定
```bash
# 統括管理
code startup_scripts_template/run_a.sh  # Manager

# チームリーダー
code startup_scripts_template/run_b.sh  # Frontend Leader
code startup_scripts_template/run_c.sh  # Backend Leader
code startup_scripts_template/run_d.sh  # Infrastructure Leader

# スペシャリスト
code startup_scripts_template/run_e.sh  # Frontend Specialist
code startup_scripts_template/run_f.sh  # Backend Specialist
code startup_scripts_template/run_g.sh  # Infrastructure Specialist
code startup_scripts_template/run_h.sh  # QA Specialist
```

### 3. 複合階層用APIキー設定
```bash
# 環境変数の設定
export GEMINI_API_KEY_TYPE08='your-api-key-here'

# または .env ファイルに追記
echo "GEMINI_API_KEY_TYPE08=your-api-key-here" >> ../../.env
```

## 💬 複合階層コミュニケーション

### 階層型質問（Manager → Leaders → Specialists）
```bash
# 全階層への段階的伝達
./ask_tree.sh "新機能開発の要件を各チームで検討してください"
```

### フラット型質問（全員同時）
```bash
# 緊急時や全体会議
./ask_flat.sh "システム障害対応：各チームの状況を即座に報告"
```

### チーム別指示
```bash
# Frontend Team（Leader B + Specialist E）
tmux send-keys -t gemini-squad-8:0.1 "UI改善の方針を決定" Enter
tmux send-keys -t gemini-squad-8:0.4 "コンポーネントライブラリを更新" Enter

# Backend Team（Leader C + Specialist F）
tmux send-keys -t gemini-squad-8:0.2 "API設計の見直し" Enter
tmux send-keys -t gemini-squad-8:0.5 "データベース最適化を実施" Enter

# Infrastructure Team（Leader D + Specialist G）
tmux send-keys -t gemini-squad-8:0.3 "デプロイ戦略の策定" Enter
tmux send-keys -t gemini-squad-8:0.6 "監視システムの強化" Enter
```

### 横断的品質管理
```bash
# QA Specialist（全チーム横断）
tmux send-keys -t gemini-squad-8:0.7 "全チームの成果物を品質チェック" Enter
```

## 🛠️ Gemini CLI 複合階層運用

### 戦略レベル（Manager）
```bash
# 全体戦略の策定
gemini-cli "3つのチームの進捗を統合して全体戦略を調整"

# リソース配分の最適化
gemini-cli "各チームの負荷状況を分析してリソース再配分を提案"
```

### 戦術レベル（Leaders）
```bash
# Frontend Leader
gemini-cli "UI/UXの改善点を分析してフロントエンド戦略を策定"

# Backend Leader
gemini-cli "システムアーキテクチャの課題を特定して改善案を提示"

# Infrastructure Leader
gemini-cli "運用効率を向上させるインフラ改善計画を作成"
```

### 実行レベル（Specialists）
```bash
# Frontend Specialist
gemini-cli -f "component.tsx" "このTypeScriptコンポーネントを最適化"

# Backend Specialist
gemini-cli -f "api.py" "このAPIエンドポイントのパフォーマンスを改善"

# Infrastructure Specialist
gemini-cli -f "docker-compose.yml" "このDocker構成を本番環境用に最適化"

# QA Specialist
gemini-cli -f "test.spec.js" "このテストケースを拡張して品質を向上"
```

## 📊 複合階層実務運用パターン

### パターン1: フルスタック開発
```bash
# Manager A: プロダクトオーナー
# Leader B: フロントエンドアーキテクト
# Leader C: バックエンドアーキテクト
# Leader D: DevOpsリード
# Specialist E: React開発者
# Specialist F: Node.js開発者
# Specialist G: Kubernetes管理者
# Specialist H: テストエンジニア
```

### パターン2: マイクロサービス開発
```bash
# Manager A: システムアーキテクト
# Leader B: サービスA責任者
# Leader C: サービスB責任者
# Leader D: 共通基盤責任者
# Specialist E: サービスA開発者
# Specialist F: サービスB開発者
# Specialist G: 基盤エンジニア
# Specialist H: 統合テスト担当
```

### パターン3: データプラットフォーム
```bash
# Manager A: データ戦略責任者
# Leader B: データ収集チーム
# Leader C: データ処理チーム
# Leader D: データ活用チーム
# Specialist E: データエンジニア
# Specialist F: データサイエンティスト
# Specialist G: MLエンジニア
# Specialist H: データ品質管理者
```

## 🔄 複合階層ワークフロー

### 1. 戦略策定フェーズ（Manager主導）
```bash
# 全体戦略の決定
tmux send-keys -t gemini-squad-8:0.0 "プロジェクト全体の戦略を策定" Enter

# リーダーへの戦略伝達
./ask_tree.sh "以下の戦略に基づいて各チームの計画を立案してください"
```

### 2. チーム計画フェーズ（Leaders主導）
```bash
# 各チームでの計画策定
for i in {1..3}; do
    tmux send-keys -t gemini-squad-8:0.$i "チーム戦術計画を策定" Enter
done

# スペシャリストへの指示
for i in {4..7}; do
    tmux send-keys -t gemini-squad-8:0.$i "担当領域の詳細計画を作成" Enter
done
```

### 3. 並列実行フェーズ（Specialists主導）
```bash
# チーム別並列作業
# Frontend Team
tmux send-keys -t gemini-squad-8:0.1 "フロントエンド作業を統括" Enter
tmux send-keys -t gemini-squad-8:0.4 "UI実装を開始" Enter

# Backend Team
tmux send-keys -t gemini-squad-8:0.2 "バックエンド作業を統括" Enter
tmux send-keys -t gemini-squad-8:0.5 "API実装を開始" Enter

# Infrastructure Team
tmux send-keys -t gemini-squad-8:0.3 "インフラ作業を統括" Enter
tmux send-keys -t gemini-squad-8:0.6 "環境構築を開始" Enter

# QA（横断的品質管理）
tmux send-keys -t gemini-squad-8:0.7 "品質管理プロセスを開始" Enter
```

### 4. 統合・調整フェーズ（全階層連携）
```bash
# チーム間の調整
./ask_tree.sh "チーム間の依存関係を確認して調整してください"

# 品質チェック
tmux send-keys -t gemini-squad-8:0.7 "全チームの成果物を統合テスト" Enter

# 最終統合
tmux send-keys -t gemini-squad-8:0.0 "全体統合と最終確認" Enter
```

## 🎯 複合階層管理のベストプラクティス

### 1. 明確な責任分界
```bash
# Manager: 戦略決定、リソース配分、最終責任
# Leaders: 戦術実行、チーム管理、品質責任
# Specialists: 技術実装、専門性発揮、成果物責任
```

### 2. 効率的な情報流通
```bash
# 縦の情報流通（階層間）
./ask_tree.sh "重要な決定事項を階層順に伝達"

# 横の情報流通（同階層間）
./ask_flat.sh "同じレベルのメンバー間で情報共有"

# 斜めの情報流通（チーム間連携）
# Leader間の直接連携
for i in {1..3}; do
    tmux send-keys -t gemini-squad-8:0.$i "他チームリーダーと連携" Enter
done
```

### 3. 段階的エスカレーション
```bash
# Level 1: Specialist間で解決
# Level 2: 担当Leaderに相談
# Level 3: 他チームLeaderと調整
# Level 4: Managerに報告・決定依頼
```

## 🚨 複合階層トラブルシューティング

### チーム間の競合解決
```bash
# リーダー間での調整
for i in {1..3}; do
    tmux send-keys -t gemini-squad-8:0.$i "チーム間の競合を調整" Enter
done

# マネージャーによる最終調整
tmux send-keys -t gemini-squad-8:0.0 "チーム間競合の最終解決" Enter
```

### 技術的依存関係の問題
```bash
# 依存関係の可視化
./ask_tree.sh "各チームの技術的依存関係を明確化"

# 優先順位の調整
tmux send-keys -t gemini-squad-8:0.0 "技術的依存関係に基づく優先順位調整" Enter
```

### リソース不足への対応
```bash
# リソース状況の把握
./ask_flat.sh "各チームのリソース使用状況を報告"

# リソース再配分
tmux send-keys -t gemini-squad-8:0.0 "リソース再配分計画を策定" Enter
```

## 📈 複合階層パフォーマンス最適化

### 1. チーム間シナジー効果
```bash
# 定期的なチーム間レビュー
./ask_tree.sh "チーム間の連携効果を評価"

# ベストプラクティス共有
./ask_flat.sh "各チームの成功事例を全体で共有"
```

### 2. 専門性の相互活用
```bash
# クロスファンクショナルな協力
for i in {4..7}; do
    tmux send-keys -t gemini-squad-8:0.$i "他チームの専門知識を活用" Enter
done
```

### 3. 継続的な組織学習
```bash
# 定期的な振り返り
./ask_tree.sh "プロジェクトの振り返りと改善点の抽出"

# 組織知識の蓄積
tmux send-keys -t gemini-squad-8:0.0 "学習内容を組織知識として蓄積" Enter
```

## 🔗 複合階層管理ツール

### コミュニケーションツール
- `ask_tree.sh`: 階層型コミュニケーション
- `ask_flat.sh`: フラット型コミュニケーション
- `tmux_layout.sh`: 複合階層レイアウト設定

### 管理ファイル
- `instructions/`: 階層・役割別指示書
- `startup_scripts_template/`: チーム別起動スクリプト
- `load_env.sh`: 環境設定

## 📝 複合階層カスタマイズ例

### 大規模Webサービス開発
```bash
# Manager: プロダクトディレクター
# Leader B: フロントエンドアーキテクト
# Leader C: バックエンドアーキテクト
# Leader D: SREリード
# Specialist E: React/TypeScript開発者
# Specialist F: Go/Python開発者
# Specialist G: Kubernetes/AWS専門家
# Specialist H: テスト自動化エンジニア
```

### AI/MLプラットフォーム開発
```bash
# Manager: AIプロダクトマネージャー
# Leader B: データエンジニアリングリード
# Leader C: MLエンジニアリングリード
# Leader D: MLOpsリード
# Specialist E: データパイプライン開発者
# Specialist F: モデル開発者
# Specialist G: MLOpsエンジニア
# Specialist H: モデル評価・品質管理者
```

### エンタープライズシステム開発
```bash
# Manager: システム統括責任者
# Leader B: 業務システムリード
# Leader C: 基盤システムリード
# Leader D: セキュリティリード
# Specialist E: 業務アプリケーション開発者
# Specialist F: 基盤サービス開発者
# Specialist G: セキュリティエンジニア
# Specialist H: システム統合テスト担当
```

---

**重要**: 複合階層構造の利点を最大化するため、
各チーム間の連携を重視し、明確な役割分担と効率的な情報共有を実現してください。
特に横断的な品質管理と継続的な組織学習が成功の鍵となります。