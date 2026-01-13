################################################################################
# マンガ作品別 掲載話数ランキンググラフ作成スクリプト
#
# 機能:
#   CSV形式の掲載情報データを入力とし、作品ごとの話数を集計。
#   掲載話数の多い順（降順）に上位20作品を抽出し、横棒グラフを生成する。
#
# 依存パッケージ:
#   - tidyverse (dplyr, ggplot2, readr, forcats などを含む)
#
# 実行方法:
#   ターミナルから以下のように実行する。
#   $ Rscript create_chart.R <入力ファイルパス>
#
#   例:
#   $ Rscript create_chart.R data/cm_ce.csv
#
################################################################################


# -- 1. ライブラリの読み込み --
# データ整形と可視化に必要なtidyverseパッケージを読み込む。
library(tidyverse)


# -- 2. コマンドライン引数の処理 --
# `Rscript`コマンドに続く引数のみを取得 (`trailingOnly = TRUE`)。
args <- commandArgs(trailingOnly = TRUE)

# 引数が指定されていない場合は、エラーメッセージを表示して終了。
if (length(args) == 0) {
  stop("入力ファイル名を指定してください。例: Rscript create_chart.R <ファイルパス>", call. = FALSE)
}
input_file <- args[1]
output_file <- "manga_ranking.png" # 出力するグラフ画像ファイル名


# -- 3. データの読み込みと集計 --
# CSVファイルをデータフレームとして読み込む。
manga_data <- readr::read_csv(input_file)

# パイプ演算子 (%>%) を用いて、一連のデータ処理を実行。
top20_manga <- manga_data %>%
  # 作品名(ccname)ごとにデータ行数を数え、"episode_count"列を作成。
  dplyr::count(ccname, name = "episode_count") %>%
  # 話数(episode_count)の降順にソート。
  dplyr::arrange(desc(episode_count)) %>%
  # 上位20作品を抽出。
  dplyr::top_n(20, wt = episode_count) %>%
  # グラフのY軸の順序を整えるため、作品名(ccname)をファクター型に変換。
  # episode_countの値に基づき、降順(.desc = TRUE)で並べ替える。
  # これにより、グラフ上では話数が多い作品が下方に表示される。
  dplyr::mutate(ccname = forcats::fct_reorder(ccname, episode_count, .desc = TRUE))


# -- 4. グラフの描画と保存 --
# ggplot2の文法に基づき、グラフオブジェクトを生成。
plot <- ggplot(top20_manga, aes(x = episode_count, y = ccname)) +
  # 棒グラフを描画。棒の色は"steelblue"に固定。
  geom_col(fill = "steelblue") +
  # 各棒の右端に話数のテキストラベルを表示。
  geom_text(aes(label = episode_count), hjust = -0.2, size = 3) +
  # グラフのタイトルと各軸のラベルを設定。
  labs(
    x = "合計話数",
    y = "マンガ作品名"
  ) +
  # シンプルな白背景のテーマを適用。macOS向けの日本語フォントを指定。
  theme_minimal(base_family = "HiraginoSans-W3") +
  # 凡例(legend)を非表示にし、グラフタイトルを中央揃えに設定。
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )

# 作成したグラフをPNGファイルとして保存。
ggsave(output_file, plot, width = 12, height = 8, dpi = 150)

# 処理の完了をコンソールに通知。
cat("グラフを '", output_file, "' として保存しました。\n", sep = "")
