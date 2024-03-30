#
# php_method_comment
# 
# @version
#
BEGIN {
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
    } else if(match($0, /^[[:space:]]*(final[[:space:]]+)?(abstract[[space:]]+)?((public|protected|privete)[[:space:]]+)?(function[[:space:]]*).*$/)) {
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
}

#
# キュー出力
#
function output_queue()
{
    for(i=0; i<length(queue); i++) {
        print queue[i]
        delete queue[i]
    }

    queue_count = 0
    queue[queue_count] = ""
}

#
# コメント作成
#
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

    contents_count = 0
    contents[contents_count]=""

    for(i=0; i<length(queue); i++) {
        #function行
        if(match(queue[i], /function/)) {
            #引数含む
            if(match(queue[i], /\)/)) {
                arg_start = index(queue[i], "(")
                arg_end = index(queue[i], ")")

                contents[contents_count] = substr(queue[i], 0, arg_start)
                contents_count++

                argstr = substr(queue[i],arg_start, arg_end - arg_start)
                split(argstr, args, /,/)
                
                for(j=1; j<=length(args); j++) {
                    contents[contents_count] = args[i]
                    contents_count++
                }

                contents[contents_count] = substr(queue[i], arg_end)
                contents_count++

            } else {
                contents[contents_count] = queue[i]
                contents_count++
            }
        #引数行
        } else if(match(queue[i], /\$/)) {
            contents[contents_count] = queue[i]
            contents_count++
        #戻値行
        } else if(match(queue[i], /:/)) {
            contents[contents_count] = queue[i]
            contents_count++
        }
    }
    
    output_comment(contents, indent)

    print indent"*/"
}

#
# コメント出力
#
# @param string row
# @param string indent
#
function output_comment(  contents, indent)
{
    for(i=0; i<length(contents); i++) {
        #function行
        if(match(contents[i], /function/)) {
            output_function_comment(contents[i], indent) 
        #引数行
        } else if(match(contents[i], /\$/)) {
            output_arg_comment(contents[i], indent) 
        #戻値行
        } else if(match(contents[i], /:/)) {
            output_return_comment(contents[i], indent) 
        }
    }
}
