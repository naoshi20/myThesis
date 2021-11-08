This repository is about my thesis.

## 環境構築
* docker run -e PASSWORD=password -p 8787:8787 -v $PWD:/home/rstudio -d --name r-mutou ykunisato/paper-r
* ブラウザで localhost:8787にアクセス。
右上のreproduction_mentalrotationのところから、face_emoのRプロジェクトを開く

## ファイル実行方法
* source("<実行したいファイル名>", echo = TRUE)
