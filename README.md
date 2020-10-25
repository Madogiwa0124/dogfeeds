[![CircleCI](https://circleci.com/gh/Madogiwa0124/dogfeeds.svg?style=svg)](https://circleci.com/gh/Madogiwa0124/dogfeeds)

# README
DogFeedsは、RSSフィードをまとめて・共有できるRSSリーダーです。
複数のRSSをまとめたRSSフィードを作成することが出来ます。

下記のような2つのRSSのエンドポイントを、、、

* https://example.com/foo/rss
* https://example.com/bar/rss

DogFeedsを使うと下記のように1つにまとめることが出来ます:dog:

* https://dogfeeds.herokuapp.com/boards/xxx.rss

便利ポイント

* Slack等でRSSを連携するときに1個1個登録しなくていい :dog2::sparkles:

* 管理画面から、まとめたRSSを変更できるのでSlack等に登録済みのRSSのURLを変更せずに中身を修正できる :dog2::sparkles:

# development

環境構築には[dip](https://github.com/bibendi/dip)を使用しているので、ローカル環境に`dip`をinstallしてください。

``` sh
$ gem install dip
```

install後は下記のコマンドを実行すると開発環境ができあがります。

``` sh
$ dip provision
```

:video_game: コマンド一覧

``` sh
$ dip ls
```

# Contributing

なにかバグ等があればissueまで🙏

https://github.com/Madogiwa0124/dogfeeds/issues/new
