# phpunit ver9=>ver11 バージョンアップ対応

UnitTestファイルをVer11用に書き換える

## 使い方

```bash

phpunit_doc2attr.sh FILE|DIR

```

## 変換内容

- @testをAttributeにする
- @dataProviderをAttributeにする
- DocComment内の @test @dataProvider は削除する
- Attribute用use行を追加する

