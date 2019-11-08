### graphql実装
![2019-02-17 10 45 19](https://user-images.githubusercontent.com/35171408/52907260-2bf34f00-32a1-11e9-8c20-3237ee7e0746.png)
　
**Procedure**
```
1, Put these 2 gems in Gemfile and bundle install
gem 'graphql', '<= 1.7'
gem 'graphiql-rails', '<= 1.5'

2, Create Model and migration file for DB
rails g graphql:object Blog id:ID! title:String! text:String!

3, Implement app/graphql/types/blog_type.rb
https://github.com/YukiTamura14/graphql_app/blob/master/app/graphql/types/blog_type.rb

4, Implement app/graphql/types/query_type.rb
https://github.com/YukiTamura14/graphql_app/blob/master/app/graphql/types/query_type.rb

5, Implement  app/controllers/graphql_controller.rb
https://github.com/YukiTamura14/graphql_app/blob/5558a6af584179daa0cea034490abed6d02b6a3b/app/controllers/graphql_controller.rb
```
　
### SQLインジェクションとは?  
### What is SQL Injenction?
「データベースと連携したウェブアプリケーションの多くは、利用者からの入力情報を基に SQL 文（データベースへの命令文）を組み立てている。ここで、SQL 文の組み立て方法に問題がある場合、攻撃によってデータベースの不正利用をまねく可能性がある。このような問題を「SQL インジェクションの脆弱性」と呼び、問題を悪用した攻撃を、「SQL インジェクション攻撃」と呼ぶ。」

「入力された値によっては意図しないSQLが生成され、結果として不正にDBのデータが読み取られたり、データが改ざんまたは削除されたりするなどの被害をこうむる可能性がある。」

"Many web applications linked with databases assemble SQL statements (it is command statements to the database) based on user input information. If there is a problem with the SQL statement assembly, the problem is called “SQL injection vulnerability”, and an attack that exploits this problem is called “SQL injection attack". "  

"Unexpected SQL may be generated depending on the input value, and as a result, data in the database may be illegally used, or data may be altered or deleted."  

### formに埋め込まれたトークン（ランダムな文字列）のスクリーンショット
### Screenshot of token (random string) embedded in form
![2019-02-17 13 34 58](https://user-images.githubusercontent.com/35171408/52917423-a4ecb800-332e-11e9-9e78-dfb944438189.png)

### sendメソッドの危険性  
### Danger of send method  
外部から入力された値をObject#sendやpublic_sendメソッドにそのまま渡すのは避けた方がいい。  
危険なコード例  
```
def some_action
  FooModel.find_by_id(params[:id]).send(params[:method])
  ...
end
```
このようなactionのparams[:method]に例えばexitという文字列を送った場合、Railsアプリを終了させることができてしまう。なぜなら、RubyのほとんどすべてのオブジェクトはKernelモジュールをincludeしているため、exitはプログラムのどこからでも呼べる。

そのため、sendに任意の文字列を渡せるようなコードを書いてしまうと、Objectが使える任意のメソッド、すなわちKernelモジュールのメソッドが呼べてしまい、脆弱性を作ることになる。  

参考URL：
https://qiita.com/igrep/items/b2fed2d467f8a16f5eb0

It is better not to pass the value input from outside to Object#send or "public_send" method as it is.
Here is a dangerous code example
```
def some_action
  FooModel.find_by_id (params [: id]). send (params [:method])
　Omitted
end
```
For example, if you send the string "exit" to params [:method] such like in this "some_action" action, you can quit the Rails app. Because almost every objects in Ruby includes a Kernel module, so "exit" can be called from anywhere in the program.

Therefore, if you write code that can pass an arbitrary string to "send", you can call any method that Object can use, and hence the method of the Kernel module, then will creat vulnerability.
