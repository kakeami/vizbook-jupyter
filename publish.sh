#!/bin/bash

# --- 1. エラー発生時に即座に停止 ---
set -e

# --- 2. 変数・設定 ---
EXPECTED_REPO="kakeami/vizbook-jupyter"
ENV_NAME="jupyterbook-env"
BOOK_DIR="book"
BUILD_DIR="book/_build/html"
REMOTE="origin"
BRANCH="main"
PUB_BRANCH="gh-pages"

# --- 3. 引数（コミットメッセージ）のチェック ---
if [ -z "$1" ]; then
    echo "❌ エラー: コミットメッセージを入力してください。"
    echo "使用法: ./publish.sh \"メッセージ内容\""
    exit 1
fi

# --- 4. 安全装置：オリジナルのリポジトリか確認 ---
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [[ "$REMOTE_URL" != *"$EXPECTED_REPO"* ]]; then
    echo "⚠️  安全装置が作動しました:"
    echo "このスクリプトはオリジナルのリポジトリ ($EXPECTED_REPO) 専用です。"
    echo "フォーク先での意図しない公開を防ぐため、実行を中止しました。"
    exit 1
fi

# --- 5. 仮想環境の有効化 ---
if [ -f "./$ENV_NAME/bin/activate" ]; then
    echo "🌐 仮想環境 $ENV_NAME を有効化中..."
    source "$ENV_NAME/bin/activate"
else
    echo "❌ エラー: 仮想環境 $ENV_NAME が見つかりません。"
    exit 1
fi

# --- 6. 依存ツールの確認 ---
if ! command -v ghp-import &> /dev/null; then
    echo "📦 ghp-import をインストールしています..."
    pip install ghp-import
fi

# --- 7. ビルドプロセス ---
echo "🛠️  ビルドプロセスを開始します..."
echo "  -> セル非表示スクリプトを実行中..."
python ./src/hide_cells.py

echo "  -> Jupyter Book をビルド中..."
jupyter-book build "$BOOK_DIR"

# --- 8. ソースコードのコミット & プッシュ ---
echo "📝 ソースコードを $BRANCH ブランチへ反映中..."
git add .
# 👓️ を冠した公式アップデート用メッセージ
git commit -m "👓️ [Update] $1"
git push "$REMOTE" "$BRANCH"

# --- 9. GitHub Pages へのデプロイ ---
echo "🚀 公開用ファイルを $PUB_BRANCH ブランチへデプロイ中..."
# -n: .nojekyll を含める, -p: pushまで行う, -f: ディレクトリ指定
ghp-import -n -p -f "$BUILD_DIR"

echo "--------------------------------------------------"
echo "✅ すべての工程が正常に完了しました！"
echo "👓️ サポートサイトの更新が間もなく反映されます。"
