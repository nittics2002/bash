#
# phpunit doc-comment attribute 変換
#
# @version
#
BEGIN {
    queue_count = 0
    queue[queue_count]=""
    is_comment = 0
}
{
	#use追加
    if (match($0, /test\\Concerto\\ConcertoTestCase/) > 0) {
		print $0
		print "use PHPUnit\\Framework\\Attributes\\Test;"
		print "use PHPUnit\\Framework\\Attributes\\DataProvider;"
	#コメント行開始
    } else if (match($0, /^[[:space:]]*\/\*+/) > 0) {
    #if (match($0, /^ *\/\*+/) > 0) {
    #if (match($0, /^[[:space:]]+\/\*+[[:space:]]*$/) > 0) {
        is_comment = 1
        print $0
    #コメント行以外
    } else if(is_comment == 0) {
        print $0
    #コメント行終了
    } else if(match($0, /^ *\*+\/ *$/)) {
    #} else if(match($0, /^[[:space:]]*\*+\/[[:space:]]*$/)) {
        is_comment = 0
        print $0
        
        for (i in queue) {
            print queue[i]
            delete queue[i]
        }
    #@test comment
    } else if(match($0, /^[[:space:]]*\*[[:space:]]+@test[[:space:]]*$/)) {
        gsub("@test", "#[Test]", $0)
        gsub(/\*[[:space:]]+/, "", $0)
        queue[queue_count] = $0
        queue_count++;
    #@dataProvider
    } else if(match($0, /^[[:space:]]*\*[[:space:]]+@dataProvider.+$/)) {
        func_name = $0
        gsub("@dataProvider", "", func_name)
        #gsub("\*", "", func_name)
        gsub("*", "", func_name)
        gsub(" ", "", func_name)

        indent=$0
        gsub(/\*[[:space:]]+@dataProvider.+$/, "", indent)
        
        queue[queue_count] = indent"#[DataProvider('"func_name"')]"
        queue_count++;
    } else {
        print $0
    }
}

