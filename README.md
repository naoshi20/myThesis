This repository is about my thesis.

## 環境構築
* docker run -e PASSWORD=password -p 8787:8787 -v $PWD:/home/rstudio -d --name r-mutou ykunisato/paper-r
* ブラウザで localhost:8787にアクセス。
右上のreproduction_mentalrotationのところから、face_emoのRプロジェクトを開く

## ファイル実行方法
* source("<実行したいファイル名>", echo = TRUE)

## ディレクトリ構成
.

├── result: 分析結果の出力先

│   ├── stanRDS: stan結果を格納するバイナリファイル群
│   ├── bayesian: ベイズ統計モデリング結果を格納するファイル群
│   └── regression: 帰無仮説検定型統計モデリング結果を格納するファイル群
├── .gitignore: 公開しないファイル一覧
├── bayesian_multi_disg.R: 正規分布採用型ベイズ統計モデリング
├── bayesian_multi_disg_geometric.R: 幾何分布採用型ベイズ統計モデリング
├── bayesian_multi_disg_poisson.R: ポアソン分布採用型ベイズ統計モデリング
├── bayesian_result_multi.R: トレースプロット・事後分布出力コード
├── myfunc.R
└──regression_disg.R

.
│
├ README.md .. 目次を書く
│
├ result: 分析結果の出力先
│　├ stanRDS: stan結果を格納するバイナリファイル群
│　├ bayesian: ベイズ統計モデリング結果を格納するファイル群
│　└ regression: 帰無仮説検定型統計モデリング結果を格納するファイル群
│
├ .gitignore: 公開しないファイル一覧
├ bayesian_multi_disg.R: 正規分布採用型ベイズ統計モデリング
├ bayesian_multi_disg_geometric.R: 幾何分布採用型ベイズ統計モデリング
├ bayesian_multi_disg_poisson.R: ポアソン分布採用型ベイズ統計モデリング
├ bayesian_result_multi.R: トレースプロット・事後分布出力コード
├ myfunc.R
└ regression_disg.R

