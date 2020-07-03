# singularity imageのビルド
```
$ sudo singularity build ubuntu-18.04-apache2-jekyll.simg Singularity
```

# jekyllで静的ファイルを生成するソースの準備
適当なディレクトリを作成し、jekyllのデータをそのディレクトリ内に置く。start_container-build.sh または start_container-serve.sh の SOURCE_DIR変数の値をデータを入れたディレクトリのパスに修正する。

# singularity instance の起動
jekyllをbuildで実行してapache2のDocumentRootに静的ファイルを出力させ、生成したサイトをapache2で公開する場合はstart_container-build.shを実行します。
jekyllをserveで実行し、jekyllのhttpサーバをapache2のリバースプロキシで受ける場合はstart_container-serve.shを実行します。
いずれの場合もhttpd.conf.buildまたはhttpd.conf.serveのListenディレクティブにsingularity instanceで使用するポート番号を設定します。
