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
                pos_start = index($0, "(")
                pos_end = index($0, ")")
                arg = substr($0, pos_start + 1, pos_end - pos_start - 2) 
                
                #引数あり
                if(length(arg) > 0) {
                
                }




            parse_args()


            output_queue()
        }

    #method終了
    } else if(match($0, /^[[:space:]]*{.*$/)) {
        arg_line = 0
        parse_args()
    #引数行
    } else if(arg_line == 1) {
        queue[queue_count] = $0
        queue_count++
        
        
        gsub("@test", "#[Test]", $0)
        gsub(/\*[[:space:]]+/, "", $0)
        queue[queue_count] = $0
        queue_count++;
    #@dataProvider
    } else if(match($0, /^[[:space:]]*\*[[:space:]]+@dataProvider.+$/)) {
        func_name = $0
        gsub("@dataProvider", "", func_name)
        gsub("\*", "", func_name)
        gsub(" ", "", func_name)

        indent=$0
        gsub(/\*[[:space:]]+@dataProvider.+$/, "", indent)
        
        queue[queue_count] = indent"#[DataProvider('"func_name"')]"
        queue_count++;
    } else {
        print $0
    }
}

