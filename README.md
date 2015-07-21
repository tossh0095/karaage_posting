# KaraagePosting

唐揚げポスティングとは
## 動機
[このスライド](http://www.slideshare.net/moririring/karaage-click)に触発されて、唐揚げログを取得せねばならないと思い作成したrubygemsです。

自分が食べた唐揚げの数をライフログサービスから取得,[唐揚げ.click](https://karaage.click)に投稿するrubygemsです。
いまのところfitbit(OAuth 2.0)にしか対応していません。jawboneとかも対応していきたいと思っています。

TODO:
エラー処理の実装ができていないので、実装しないといけないなぁ・・・。

## Installation

Gemfileに下の行を追加して`$ bundle`してください。

```
gem 'karaage_posting'
```

システムに入れる場合は下記の通りです。

```
$ gem install karaage_posting
```

## 利用する前に

FitbitのAPIを利用しているので、Fitbitのデベロッパー登録が必要です。

[Fitbitのデベロッパーサイト](https://dev.fitbit.com/login)に開発者登録をして、
OAuthのコンシューマキーとコンシューマシークレットを取得してください。

こんな感じで取得できます。

```
Client (Consumer) Key
[consumer_key]
OAuth 2.0 Client ID
[client_ID]
Client (Consumer) Secret
[client_secret]
```

上記の値を`$HOME/.fitbitenv`に下記のように記述してください。
```
FITBIT_KEY="consumer_id"
FITBIT_SECRET='client_secret'
FITBIT_REDIRECT_URL='application redirect url' #デベロッパー登録のときに登録したredirectページ
```

## 使い方

```ruby
require 'karaage_posting'

#ポスティング用のオブジェクトを作成
karaage_poster = KaraagePosting::FitbitKaraagePosting.new

#OAuth2.0のauthorize codeのためのURLを取得
authorize_uri = karaage_poster.get_fitbit_authorize_uri

#
#何らかの処理でauthorize codeを取得
#

#fitbit.comのトークンを取得
karaage_poster.get_fitbit_token(authorize_code)

#YYYY-MM-DDに食べた唐揚げの数を取得
karaage_poster.get_karaage_count{'2015-07-01'}#

#karaage.clickに食べた唐揚げの数を投稿
karaage_poster.posting_number_of_karaage

```

## CLIツール

CLIツールが付属しているので、crontabに登録すると定期的にポスティングできます。

```
# 今日食べた唐揚げの数を取得しkaraage.clickに投稿する
$ karaage_posting
# YYYY-MM-DDの食べた唐揚げの数を取得しkaraage.clickに投稿する
$ karaage_posting YYYY-MM-DD
```

## Contributing

プルリク大歓迎です！

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

