#
# php
# 
# @version
#
BEBIN {
    queue_count = 0
    queue[queue_count]=""
    is_comment = 0
    has_comment = 0
    arg_line = 0
}
{
    #コメント行開始
    if (match($0, /^[[:space:]]*\/\*+/)) {
        is_comment = 1
        print $0
        has_comment = 1
    #コメント行終了
    } else if(match($0, /^ *\*+\/ *$/)) {
        is_comment = 0
        print $0
    #コメント行途中
    } else if(is_comment == 1) {
        print $0
    #method開始
    } else if(match($0, /^[[:space:]]*(final[[:space:]]+)?((public|protected|privete)[[:space:]]+)?(function[[:space:]]*).*$/)) {
        queue[queue_count] = $0
        queue_count++
        arg_line = 1

        #1行method
        if(match($0, /^.+{$/)) {
            arg_line = 0

            #コメント行あり
            if(has_comment == 1) {
                has_comment = 0
                output_queue()
            #コメント行なし
            } else {
                make_comment()
                output_queue()
            }
        }
    #method終了
    } else if(match($0, /^[[:space:]]*{.*$/)) {
        queue[queue_count] = $0
        queue_count++
        arg_line = 0

        #コメント行あり
        if(has_comment == 1) {
            has_comment = 0
            output_queue()
        #コメント行なし
        } else {
            make_comment()
            output_queue()
        }
    #引数行
    } else if(arg_line == 1) {
        queue[queue_count] = $0
        queue_count++
    } else {
        print $0
    }

    function output_queue()
    {
        for(i=0; i<length(queue); i++) {
            print queue[i]
            delete queue[i]
        }

        queue_count = 0
        queue[queue_count] = ""
    }

    function make_comment()
    {
        #インデント数カウント
        split(queue[0], ar1, /(f|p)/)
        indent_length = length(ar1)
        
        #インデント作成
        indent = ""
        for(i=0; i<indent_length; i++) {
            indent = indent" "
        }
        
        print indent"/**"

        for(i=0; i<length(queue); i++) {
            #function行
            if(match(queue[i], /function/)) {
                #引数含む
                if(match(queue[i], /\)/)) {
                    arg_start = index(queue[1], "(")
                    arg_end = index(queue[1], ")")


                }
            } else {
                split(queue[1], ar, //)

            print indent
        }
        
        print indent"*/"
    }

}

