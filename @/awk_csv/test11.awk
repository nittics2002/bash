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
        #現在列数
        split($0, columns)
        column_count = length(columns)

        if (column_count != titles_count) {
            #囲い文字フラグ
            is_enclosure = 0

            ###分割見直し
            for(i=1; i<=NF; i++) {
                #文字数
                str_length = length(columns[i])
                #囲い文字"位置
                pos = index(columns[i], "\"")
                #
                #

                if (pos == 0) {
                    continue
                } else if (pos == 1) {
                    is_enclosure = 1
                    coumns
                } else if (pos == str_length) {
                    is_enclosure = 0
                } else {
                    #       
                }
                    


        }

        for(i=1; i <=length(columns); i++) {
            print columns[i]
        }
        print "-------------"
    }
}

