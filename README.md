# データ可視化技術入門 サポートサイト

書籍「データ可視化技術入門」（技術評論社）のソースコード・Jupyter Notebookを公開しています。

## 書籍について

<table>
  <tr>
    <td align="center">
      <a href="https://gihyo.jp/book/2026/978-4-297-15271-0">
        <img src="https://gihyo.jp/assets/images/cover/2026/9784297152710.jpg" width="200" alt="Volume 1"/>
      </a>
      <br/>
      <strong>上巻</strong>
      <br/>
      <em>データを見る力・見せる技術</em>
      <br/>
    </td>
    <td align="center">
      <a href="https://gihyo.jp/book/2026/978-4-297-15273-4">
        <img src="https://gihyo.jp/assets/images/cover/2026/9784297152734.jpg" width="200" alt="Volume 2"/>
      </a>
      <br/>
      <strong>下巻</strong>
      <br/>
      <em>データを問う力・伝える技術</em>
      <br/>
    </td>
  </tr>
</table>

**サポートサイト**: https://kakeami.github.io/vizbook-jupyter/

## クイックスタート

### 想定環境

事前に下記がインストールされていることが前提です。

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.jp/compose/toc.html)
- [Git](https://git-scm.com/)

なお、私の環境は：

- macOS Monterey Version 12.5
- Docker version 20.10.17, build 100c701
- docker-compose version 1.29.2, build 5becea4c
- git version 2.39.0

です。

### GitHubリポジトリのクローン

[本書のGitHubリポジトリ](https://github.com/kakeami/vizbook-jupyter)からソースコードと前処理後のデータをダウンロードしてください。
例えば、

```sh
git clone --recursive https://github.com/kakeami/vizbook-jupyter.git
```

とターミナルでコマンドを打てば、`vizbook-jupyter`ディレクトリが作成され、
再現に必要なデータとJupyter notebookが全てダウンロードされます。

`--recursive`オプションを付けることで、MADB Labのデータを格納する`madb`ディレクトリも含めてクローンしています。
今後の分析では`madb`ディレクトリがあることが前提となりますので、必ず`--recursive`オプションをつけるようご注意ください。

データサイズが大きいため、ダウンロードにはしばらく時間がかかります。

最終的に、以下のような`vizbook-jupyter`ディレクトリをダウンロードできれば準備は完了です。

```shell
tree -L 2 vizbook-jupyter
# vizbook-jupyter
#├── Dockerfile
#├── LICENSE
#├── README.md
#├── book
#│   ├── _build
#│   ├── _config.yml
#│   ├── _toc.yml
#│   ├── appendix
#│   ├── images
#│   ├── index.md
#│   ├── references.bib
#│   ├── requirements.txt
#│   ├── vol1
#│   └── vol2
#├── build.sh
#├── data
#│   ├── an
#│   ├── cm
#│   ├── gm
#│   ├── mix
#│   └── sandbox
#├── docker-compose.yml
#├── madb
#│   ├── README.md
#│   ├── data
#│   └── doc
#└── src
#    └── hide_cells.py
```

### Jupyter Labの起動

`vizbook-jupyter`ディレクトリに移動し、下記のコマンドでコンテナを立ち上げてください。

```shell
sudo docker-compose up -d
```

このとき、パスワードの入力を求められるかもしれません。
その際、現在ログインしているユーザー（あなた自身）のパスワードを入力するようにしてください。

なお、ターミナルの仕様上、パスワードを入力しても画面には文字や `*`  （アスタリスク）が表示されません。
カーソルが動かなくても受け付けられていますので、そのままパスワードを入力して `Enter` キーを押してください。

ブラウザから`localhost:9999`にアクセスすると、下図のようにパスワード入力画面が表示されます。

![](book/images/appendix/login.png)

パスワードは`1101`です。
左のエクスプローラーから、`work` > `book`の順に選択し、解析用ディレクトリに移動してください。

![](book/images/appendix/book.png)

上図のような画面が表示されたら、準備は完了です。
以下のコマンドでコンテナを停止し、ブラウザを閉じましょう。

```shell
sudo docker-compose stop
```

### Jupyter Labのパスワードの変更

周知のパスワードを使い回すのは危険なので、必ず変更しましょう。

`vizbook-jupyter`ディレクトリ直下にある`docker-compose.yml`の最終行がパスワードに対応します。

```yaml
version: "3"
services:
  jupyterlab:
    build:
      context: .
    volumes:
      - "./:/home/jovyan/work"
    user: root
    ports:
      - "9999:8888"
    environment:
      NB_UID: 1000
      NB_GID: 1000
      GRANT_SUDO: "yes"
    command: start.sh jupyter lab --NotebookApp.password="sha1:4eff59f3895c:eca7017bd2f8f800bac660191a9a77413ed0a487"
```

最後の`"sha1:4ef..."`を適宜変更しましょう。
例えば`45510`としたい場合は、pythonで

```python
from notebook.auth import passwd
passwd("45510", "sha1")
# 'sha1:3e37a5120c15:28f9e774cfe2bc350773d360a40daafc87dc42af'
```

とすればトークンを生成できます。

このまま利用せず、必ず`1101`あるいは`45510`以外のパスワード[^four-years]を設定するようにしてください。

[^four-years]: アルファベットや記号を組み合わせ、少なくとも人手による解析が不可能なものにしましょう。

### Notebookの実行

`book`以下のNotebook（`*.ipynb`形式のファイル）と本書の対応関係は以下のとおりです[^minor-change]。
適宜コードを追加・修正することで、独自の分析を実施いただけます。

[^minor-change]: 本書のコンテンツの中心となるファイルのみを抜粋しています。

```

├── vol1
│   ├── 03
│   │   ├── cm_preprocess.ipynb # マンガデータの前処理（再実行不要）
│   │   ├── eda.ipynb           # マンガデータの基礎分析
│   │   └── index.md
│   ├── 04
│   │   ├── amounts.ipynb       # マンガデータの量を見る
│   │   ├── assocs.ipynb        # マンガデータの関係を見る
│   │   ├── dists.ipynb         # マンガデータの分布を見る
│   │   ├── index.md
│   │   └── props.ipynb         # マンガデータの内訳を見る
│   ├── 05
│   │   ├── index.md
│   │   ├── pandas.ipynb        # Pandasの基礎
│   │   ├── plotly.ipynb        # Plotlyの基礎
│   │   └── python.ipynb        # Pythonの基礎
│   └── 06
│       ├── an_eda.ipynb         # アニメデータの基礎分析
│       ├── an_preprocess.ipynb  # アニメデータの前処理（再実行不要）
│       ├── gm_eda.ipynb         # ゲームデータの基礎分析
│       ├── gm_preprocess.ipynb  # ゲームデータの前処理（再実行不要）
│       └── index.md
└── vol2
    ├── 01
    │   ├── bar.ipynb            # 棒グラフ
    │   ├── gbar.ipynb           # 集合棒グラフ
    │   ├── heatmap.ipynb        # ヒートマップ
    │   ├── index.md
    │   └── sbar.ipynb           # 積上げ棒グラフ
    ├── 02
    │   ├── box.ipynb            # 箱ひげ図
    │   ├── density.ipynb        # 密度プロット
    │   ├── hist.ipynb           # ヒストグラム
    │   ├── index.md
    │   ├── ridge.ipynb          # リッジラインプロット
    │   └── violin.ipynb         # バイオリンプロット
    ├── 03
    │   ├── area.ipynb           # 積上げ密度プロット
    │   ├── bar.ipynb            # 棒グラフ
    │   ├── index.md
    │   ├── mosaic.ipynb         # モザイクプロット
    │   ├── parallel.ipynb       # パラレルセットグラフ
    │   ├── pie.ipynba           # 円グラフ
    │   └── tree.ipynb           # ツリーマップ
    ├── 04
    │   ├── 2d.ipynb             # 二次元ヒストグラム
    │   ├── bubble.ipynb         # バブルチャート
    │   ├── connected.ipynb      # 連結散布図
    │   ├── contour.ipynb        # 等値線図
    │   ├── index.md
    │   ├── line.ipynb           # 折れ線グラフ
    │   ├── matrix.ipynb         # 散布図行列
    │   └── scatter.ipynb        # 散布図
    ├── 05
    │   ├── eda.ipynb            # メディア展開データの基礎分析
    │   ├── index.md
    │   └── mix_preprocess.ipynb # メディア展開データの前処理（再実行不要）
    └── 06
        ├── amounts.ipynb         # メディア展開データの量を見る
        ├── assocs.ipynb          # メディア展開データの関係を見る
        ├── dists.ipynb           # メディア展開データの分布を見る
        ├── index.md
        └── props.ipynb           # メディア展開データの内訳を見る
```

前処理後のデータは全て`vizbook-jupyter/data/*`以下に格納されています。
本書の再現のため、前処理を再実行頂く必要はありません。
（仮に再実行したとしても、同じファイルが出力されるだけですので問題はありません。）

## ライセンス

MIT License

## 著者

**Kakeami**

都内マーケティング会社で数理モデルの研究に従事する傍ら、ジョージア工科大学大学院で計算機科学を専攻。
少年時代はマンガ家に憧れ、現在はデータ分析という形で日本のポップカルチャーに向き合う。
難解な概念を身近なデータで解き明かし、学習者が直面する理論と実践の壁を取り払うことを目指す。
二児の父。

- **しずかなインターネット** - [`kakeami`](https://sizu.me/kakeami)
- GitHub - [`kakeami`](https://github.com/kakeami)
- Zenn.dev - [`kakeami`](https://zenn.dev/kakeami)
- Email - kakeami `dot` contact `at` gmail `dot` com
