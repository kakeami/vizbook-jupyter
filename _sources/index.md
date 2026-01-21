# データ可視化技術入門

このサイトでは、
書籍「データ可視化技術入門」の再現環境、データ、そして練習問題を公開します。

## この本について

本書は上巻と下巻の分冊構成となっており、それぞれ基本と応用に焦点を当てています。

::::{grid} 1 1 2 2
:class-container: text-center
:gutter: 3

:::{grid-item-card}
:link: https://gihyo.jp/book
:class-header: bg-light

**上巻**：データを見る力・見せる技術
^^^
```{image} images/index/vol1.jpg
:height: 200
```
:::

:::{grid-item-card}
:link: https://gihyo.jp/book
:class-header: bg-light

**下巻**：データを問う力・伝える技術
^^^
```{image} images/index/vol2.jpg
:height: 200
```
:::
::::

<!-- TODO
書影、リンク先、タイトルを更新
-->

上巻は3部構成です。

- **第1部**：データ可視化の導入
    - 第1章：定義、目的、ツール
    - 第2章：構成要素、手法、留意点
- **第2部**：マンガデータを使ったハンズオン
    - 第3章：データの準備（取得、前処理、基礎分析）
    - 第4章：データの可視化
- **第3部** : 基本技術の解説
    - 第5章：Python、Pandas、Plotlyの基礎
    - 第6章：データの準備の基礎
    - 第7章：データ可視化の将来

下巻は2部構成です。

- **第1部**：各可視化手法の包括的解説
    - 第1章：量を見るための手法
    - 第2章：分布を見るための手法
    - 第3章：内訳を見るための手法
    - 第4章：変数間の関係を見るための手法
- **第2部** : メディア展開データを用いた総復習のハンズオン
    - 第5章：データの準備（取得、前処理、基礎分析）
    - 第6章：データの可視化

## このサイトについて

このサイトは、本書で紹介したソースコードを公開・解説することを目的にしています。
また、各章末には**本サイト限定の練習問題**（全74問）を掲載しています。
難易度別に整理された[練習問題一覧](./appendix/practice-index)もご活用ください。

### 上巻

::::{grid} 1 1 2 2
:class-container: text-center
:gutter: 3

:::{grid-item-card}
:link: vol1/03/index
:link-type: doc
:class-header: bg-light

**3章 マンガデータ分析①**
^^^
```{image} images/index/03.png
:height: 100
```
マンガデータの取得、前処理、そして基礎分析を行います。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol1/04/index
:link-type: doc
:class-header: bg-light

**4章 マンガデータ分析②**
^^^
```{image} images/index/04.png
:height: 100
```
ハンズオン形式で、本書で取り扱う可視化手法一式を紹介します。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol1/05/index
:link-type: doc
:class-header: bg-light


**5章 Python/Pandas/Plotly**
^^^
```{image} images/index/05.png
:height: 100
```
本書で取り上げる技術の基礎をなす、Python、Pandas、そしてPlotlyの基本事項を学びます。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol1/06/index
:link-type: doc
:class-header: bg-light

**6章 取得/前処理/基礎分析**
^^^
```{image} images/index/06.png
:height: 100
```
下巻に向け、アニメ・ゲームデータの取得、前処理、そして基礎分析を取り上げます。
+++
つづきを読む {fas}`arrow-right`
:::

::::

### 下巻

::::{grid} 1 1 2 2
:class-container: text-center
:gutter: 3

:::{grid-item-card}
:link: vol2/01/index
:link-type: doc
:class-header: bg-light

**1章 量を見る手法**
^^^
```{image} images/index/08.png
:height: 100
```
棒グラフを始めとする、量を見るための手法を取り上げます。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol2/02/index
:link-type: doc
:class-header: bg-light

**2章 分布を見る手法**
^^^
```{image} images/index/09.png
:height: 100
```
ヒストグラムを始めとする、分布を見るための手法を取り上げます。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol2/03/index
:link-type: doc
:class-header: bg-light

**3章 内訳を見る手法**
^^^
```{image} images/index/10.png
:height: 100
```
円グラフを始めとする、内訳を見るための手法を取り上げます。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol2/04/index
:link-type: doc
:class-header: bg-light

**4章 関係を見る手法**
^^^
```{image} images/index/11.png
:height: 100
```
散布図を始めとする、変数間の関係を見るための手法を取り上げます。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol2/05/index
:link-type: doc
:class-header: bg-light

**5章 メディア展開データ分析①**
^^^
```{image} images/index/12.png
:height: 100
```
ハンズオン形式で、マンガ作品のアニメ化に関するデータを取得、前処理、そして基礎分析します。
+++
つづきを読む {fas}`arrow-right`
:::

:::{grid-item-card}
:link: vol2/06/index
:link-type: doc
:class-header: bg-light

**6章 メディア展開データ分析②**
^^^
```{image} images/index/13.png
:height: 100
```
マンガ作品のアニメ化に関するデータに対して、本書で取り上げた全手法を適用して総復習します。
+++
つづきを読む {fas}`arrow-right`
:::
::::

なお、ドット絵は[DOTOWN](https://dotown.maeda-design-room.net/)で公開されているものを利用させて頂きました。
ありがとうございました。

## 筆者について

::::{grid} 2 2 2 2

:::{grid-item}
:columns: 4
```{image} images/index/kakeami.jpg
:class: m-auto
:width: 200px
```
:::

:::{grid-item}
:columns: 7
**Kakeami**

都内マーケティング会社で数理モデルの研究に従事する傍ら、ジョージア工科大学大学院で計算機科学を専攻。
少年時代はマンガ家に憧れ、現在はデータ分析という形で日本のポップカルチャーに向き合う。
難解な概念を身近なデータで解き明かし、学習者が直面する理論と実践の壁を取り払うことを目指す。
二児の父。

- **しずかなインターネット** - [`kakeami`](https://sizu.me/kakeami)
- GitHub - [`kakeami`](https://github.com/kakeami)
- Zenn.dev - [`kakeami`](https://zenn.dev/kakeami)
- Email - kakeami `dot` contact `at` gmail `dot` com

:::
::::
