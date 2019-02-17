graphql実装
![2019-02-17 10 45 19](https://user-images.githubusercontent.com/35171408/52907260-2bf34f00-32a1-11e9-8c20-3237ee7e0746.png)

SQLインジェクションとは?  
「データベースと連携したウェブアプリケーションの多くは、利用者からの入力情報を基に SQL 文（データベースへの命令文）を組み立てている。ここで、SQL 文の組み立て方法に問題がある場合、攻撃によってデータベースの不正利用をまねく可能性がある。このような問題を「SQL インジェクションの脆弱性」と呼び、問題を悪用した攻撃を、「SQL インジェクション攻撃」と呼ぶ。」

「入力された値によっては意図しないSQLが生成され、結果として不正にDBのデータが読み取られたり、データが改ざんまたは削除されたりするなどの被害をこうむる可能性がある
。」

formに埋め込まれたトークン（ランダムな文字列）のスクリーンショット
![2019-02-17 13 34 58](https://user-images.githubusercontent.com/35171408/52917423-a4ecb800-332e-11e9-9e78-dfb944438189.png)

sendメソッドの危険性  
外部から入力された値をObject#sendやpublic_sendメソッドにそのまま渡すのは避けた方がいい。  
危険なコード例  
```
def some_action
  FooModel.find_by_id(params[:id]).send(params[:method])
  ...
end
```
このようなactionのparams[:method]に例えばexitという文字列を送った場合、Railsアプリを終了させることができてしまう。なぜなら、RubyのほとんどすべてのオブジェクトはKernelモジュールをincludeしているため、exitはプログラムのどこからでも呼べる。

そのため、sendに任意の文字列を渡せるようなコードを書いてしまうと、Objectが使える任意のメソッド、すなわちKernelモジュールのメソッドが呼べてしまい、思脆弱性を作ることになる。
参考URL：
https://qiita.com/igrep/items/b2fed2d467f8a16f5eb0
