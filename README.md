 everyleaf_exam
 ----

☆開発環境
***


【 製作者 】shin  
【 開発環境 】ruby_on_rails  
【 使用DB 】postgre ＳＱＬ  
【 バージョン 】ruby→2.6.1 　rails→5.2.2　 psql→11.1  

***
☆概要
***
【 目的 】タスク管理システムの開発


【 データベース構成 】

| uses TB    | tasks TB    |labels TB     |task_labels TB(中間TB)| 
|:-----------:|:------------:|:------------:|:------------:|
| *カラム*|*カラム*       |*カラム*  |*カラム*              |
|name :string|title :string|   name :string    |task_id :integer             |
|email :string    |content :text |          | label_id :integer             |
|password :string|priority :string |            |              |
|       |limit :string |    |              |
|     |status :string |       |              |
| |image :string |
***