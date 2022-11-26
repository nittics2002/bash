BEGIN {
    FS = ","
    #先頭行フラグ
    is_first_row = 1
}
{
    if (is_first_row == 1) {
        #列数
        split($0, titles)
        titles_count = length(titles)

        is_first_row = 0
    } else {
        #現在列数と処理用配列
        split($0, columns)
        column_count = length(columns)

        if (column_count != titles_count) {
            #囲い文字フラグ
            is_enclosure = 0
            #作業用分割配列
            split($0, work_columns)
            #処理用配列リセット
            delete columns
            #処理用配列位置
            current_pos = 1

            ###分割見直し
            for(i=1; i<=NF; i++) {
                #文字数
                str_length = length(work_columns[i])
                #囲い文字"位置
                enclusure_pos = index(work_columns[i], "\"")

                if (is_enclosure == 0) {
                    if (enclusure_pos == 0) {
                        columns[current_pos] = columns[current_pos] work_columns[i]
                        current_pos++
                    } else if (enclusure_pos == 1) {
                        columns[current_pos] = columns[current_pos] work_columns[i]
                        is_enclosure = 1
                    } else if (enclusure_pos == str_length) {
                        columns[current_pos] = columns[current_pos] work_columns[i]
                    } else {
                        columns[current_pos] = columns[current_pos] work_columns[i]
                    }
                } else {
                    if (enclusure_pos == 0) {
                        columns[current_pos] = columns[current_pos] "," work_columns[i]
                    } else if (enclusure_pos == 1) {
                        columns[current_pos] = columns[current_pos] "," work_columns[i]
                    } else if (enclusure_pos == str_length) {
                        columns[current_pos] = columns[current_pos] "," work_columns[i]
                        is_enclosure = 0
                        current_pos++
                    } else {
                        columns[current_pos] = columns[current_pos] "," work_columns[i]
                    }
                }
            }
        }

        for(i=1; i <=length(columns); i++) {
            print columns[i]
        }
        print "-------------"
    }
}

