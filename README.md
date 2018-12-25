# Rails x Clova スキルサンプル

Ruby on Rails で [Clova スキル](https://clova-developers.line.biz/#/) を開発するサンプルコードです。
コードの詳細な内容などは [Ruby on Rails で作る！ Clova スキル 〜LINE 連携もあるよ〜](https://engineering.linecorp.com/ja/blog/clova-ruby-on-rails/) にまとめられておりますので、ご一読いただければ幸いです。

## Install

Clone をした後、適宜 `config/database.yml` や `config/environments/development.rb` を書き換えてお使いください。
設定周りについては、ほぼ `rails new . -d mysql -S -J` で出来上がるデフォルトのものと同一です。

もしも手元に正規の `master.key` をお持ちであればそのまま起動できます。
もしも手元に `master.key` がない場合は、以下の手順で LINE の Messaging API を使用するための設定をしてください。

```console
$ rm config/credentials.yml.enc # 既存の暗号化設定ファイルを削除する
$ ./bin/rails credentials:edit # 新規に設定ファイルの編集を開始する
```

credentials を編集する際には下記に示すように LINE Developers より LINEログイン, Messaging API 用のチャネル設定を追記してください。

```yaml:config/credentials.yml
# config/credentials.yml
line:
  channel_id: YOUR_LINE_LOGIN_CHANNEL_ID
  channel_secret: YOUR_LINE_LOGIN_CHANNEL_SECRET
line_bot:
  channel_id: YOUR_MESSAGING_API_CHANNEL_ID
  channel_secret: YOUR_MESSAGING_API_CHANNEL_SECRET
  access_token: YOUR_MESSAGING_API_LONGTERM_TOKEN
```
