#cpでsrc-destが同名の場合、suffix+番号にする

## 例

`bash
#file1をカレントにコピー　default suffixを付ける
cpb file1
#   file1
#   file1.1
#   file1.2
`

`bash
#fileをカレントにfile2としてコピー　重複はdefault suffixを付ける
cpb file1 file2
#   file2
#   file2.1
#   file2.2
`

`bash
#fileをカレントにコピー　suffixを付ける
cpb -s suffix file1
#   file1
#   file1SUFFIX
#   file1SUFFIX.1
#   file1SUFFIX.2
`

`bash
#fileをカレントにfile2としてコピー　重複はsuffixを付ける
cpb -s suffix file1 file2
#   file2
#   file2SUFFIX
#   file2SUFFIX.1
#   file2SUFFIX.2
`

`bash
#fileをdirにfile1としてコピー　重複はdefault suffixを付ける
cpb file1 dir
#   dir/file1
#   dir/file1.1
#   dir/file1.2
`

`bash
#fileをdirにfile2としてコピー　重複はdefault suffixを付ける
cpb file1 dir/file2
#   dir/file2
#   dir/file2SUFFIX
#   dir/file2SUFFIX.1
#   dir/file2SUFFIX.2
`

`bash
#file1をカレントにコピー　default suffixを付ける
cpb dir/file1
#   dir/file1
#   dir/file1.1
#   dir/file1.2
`
