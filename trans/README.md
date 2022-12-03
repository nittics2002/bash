# コマンドラインでEXCITE翻訳

##使い方

`bash
#  $before_lang 変換前言語
#  $after_lang 変換後言語
#  $text 変換する文字列
#
trans_use_excite.sh $before_lang $after_lang $text
`

`bash
excite_trance>cat <<EOL |xargs -0 ./trans_use_excite.sh EN JA
 A history is GA loving for me.
 Do you have a book?
 Please lend me.
EOL
`

##変更履歴

- 210815 2000文字以上の入力に対応.ただし単語が切れる
