 everyleaf_exam
 ----

## ☆開発環境☆
***


【 製作者 】shin
【 開発環境 】ruby_on_rails
【 使用DB 】postgre ＳＱＬ
【 バージョン 】ruby→2.6.1 　rails→5.2.2　 psql→11.1

***
## ☆目的☆
***
タスク管理システムの開発

## ☆Herokuへのデプロイ方法☆
***
##### 1.アセットファイルをプリコンパイル
下記コマンドを実行し、、圧縮したアセットファイルを作成します。
```
$ rails assets:precompile RAILS_ENV=production
```
##### 2.Herokuにログイン
ターミナルでheroku loginコマンドを実行してログインを行います。
```
$ heroku login
```
##### 3.コミットする
git commitコマンドを使用して、コミットをします。
```
$ git add -A
$ git commit -m "Herokuデプロイ"
```
##### 4.Herokuに新しいアプリケーションを作成
デプロイしたいアプリのカレントディレクトリに位置していることを確認し、下記コマンドを実行してHerokuに新しいアプリケーションを作成します。
```
$ heroku create
```
##### 5.Herokuにデプロイをする
Herokuにデプロイしていきます。
```
$ git push heroku master
```
##### 6.データベースの移行
Herokuデータベースの作成は自動で行われますが、マイグレーション（テーブル作成）は手動で実行する必要があります。
```
$ heroku run rails db:migrate
```

## ☆データベース構成☆
***
| users TB    | tasks TB    |labels TB     |task_labels TB(中間TB)|
|:-----------:|:------------:|:------------:|:------------:|
| *カラム*|*カラム*       |*カラム*  |*カラム*              |
|name :string|title :string|   name :string    |task_id :integer             |
|email :string    |content :text |          | label_id :integer             |
|password :string|priority :string |            |              |
|       |limit :string |    |              |
|     |status :string |       |              |
| |image :string |
***