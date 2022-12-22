# ConcertoDownloadDev3

- config.lstで指定した相対URLのファイルをローカルにダウンロード(DL)する
- DLファイルはDLリスト(index.htm)よりアクセス可能

## コマンド

- ConcertoDownloadDev3.sh XXX (ユーザID)

## configファイル

- https://itcv1800005m.toshiba.local:8086/itc_work1/ からの相対URL
- クエリパラメータの指定もOK
- #で開始する行はHTMLの説明文として表示する

- 注意
	- Concerto画面の一覧表(jsonファイル)はsessionを利用している
	- その為、一覧表のDLは主となる画面をDL直後に行う事

## DLファイル

- user_dir以下に作成

## DLファイルへのアクセス

- user_dirにDLリストとしてindex.htmを作成する

- アクセス方法
	- php等でuser_dirをルートディレクトリとして、HTTPサーバを起動する
	- http://localhost:8888/index.htm にアクセスする
		- 起動スクリプト php_http.bat

##ファイル構成

user_dir/				DLファイルDIR(スクリプト生成)
	index.htm			DLリスト
temp/					一時ファイルDIR(スクリプト生成)
	cookie.txt			クッキーファイル
	work.htm			一時出力ファイル
ConcertoDownloadDev3.sh	実行スクリプト
php_http.bat			httpサーバ起動スクリプト
readme.md				本書
