#!/bin/bash
##############################
#
#	ConcertoDownloadDev3
#
##############################

# set -e
# set -x

##############################
#設定
##############################
#ユーザDL dir
readonly user_dir="$(pwd)/user_dir"

#DLファイルリストHTML
readonly download_list_file="${user_dir}/index.htm"

#DLファイルリスト アクセスURL(root dir=$user_dir)
readonly download_list_link=http://localhost:8888/

#temp dir
readonly temp_dir="$(pwd)/temp"

#cookie file
readonly cookie_file="${temp_dir}/cookie.txt"

#DL基準URL
readonly base_url=https://itcv1800005m.toshiba.local:8086/itc_work1/

#DL開始相対URL
readonly start_url=index.php

#proxy
readonly http_proxy=proxy.toshiba.co.jp:8080
readonly https_proxy=$http_proxy
readonly no_proxy=itcv1800005m.toshiba.local

#URL定義ファイル
readonly config_file="$(pwd)/config.lst"

readonly -A config_exts=(
	['text/html;']=.htm
	['application/json;']=.json
	['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;']=.xlsx
	['application/pdf;']=.pdf
)

#CQRS token regex pattern
readonly cqrs_pattern='<input type="hidden" name="token" value="'

#logouted regex pattern
readonly logouted_pattern='<td class="td-title">パスワード</td>'

##############################

##########
# global
##########
declare user_id
declare password
declare work_file="${temp_dir}/work.htm"

##########
#	メッセージ表示
#
#	@param [format]
#	@param [...arguments]
#
##########

function print_message() {
	if [[ $# == 0 ]];
	then
		echo
		return
	elif [[ $# == 1 ]];
	then
		echo "${1}"
		return
	fi
	
	printf "$@"
}

##########
#	引数確認
#
#	@param script_arguments
#	@return user_id
#	@error 11
#
##########

function check_arguments() {
	[[ $# != 1 ]] && cat <<EOL && exit 11

	ConcertoDownloadDev3.sh user_id

EOL

	user_id="$1"
}

##########
#	パスワード入力
#
#	@return password
#	@error 12
#
##########

function input_password() {

	#password
	read -s -p "password=" -t 10 password

	[[ -z "${password}" ]] && cat <<EOL && exit 12

	invalid password

EOL

#message
print_message

}

##########
#	作業DIR作成
#
#	@global user_dir
#	@global temp_dir
#
##########

function create_work_dir() {
	#保存先base dir clear&create
	rm -rf "${user_dir}" #2>&1 >/dev/null
	mkdir "${user_dir}"

	#temp dir clear&create
	rm -rf "${temp_dir}" #2>&1 >/dev/null
	mkdir "${temp_dir}"
}

##########
#	初期アクセス
#
#	@global cookie_file
#	@global base_url
#	@global start_url
#	@global work_file
#
##########

function init_access(){

curl \
	-k \
	--no-progress-meter \
	-c "${cookie_file}" \
	"${base_url}${start_url}" \
	> "${work_file}"

}

##########
#	CQRS token取得
#
#	@global cqrs_pattern
#	@param work_file
#	@return token
#
##########

function get_cqrs_token() {
	grep "${cqrs_pattern}" "${work_file}" | \
		sed -r 's/^.*'"${cqrs_pattern}"'(.*)".*$/\1/'
}

##########
#	CQRS token確認
#
#	@param token
#	@error 21
#
##########

function check_cqrs_token() {
	[[ ${#1} == 0 ]] && echo <<EOL && exit 21
	
	fairure token
	
EOL

	return 0
}

##########
#	認証
#
#	@global cookie_file
#	@global user_id
#	@global password
#	@global base_url
#	@global work_file
#	@param CQRS token
#	@error 22
#
##########

function authenticate() {
	curl \
		-k \
		--no-progress-meter \
		-c "${cookie_file}" \
		-b "${cookie_file}" \
		-X POST \
		-d hidden_string=login_disp \
		-d token="${1}" \
		-d user="${user_id}" \
		-d password="${password}" \
		"${base_url}index.php" \
		> "${work_file}"
	
	[[ -n $(grep "${logouted_pattern}" "${work_file}" ) ]] && \
		cat <<EOL && exit 22

	login failure

EOL

	return 0
}

##########
#	DLファイルリストheader行作成
#
#	@global download_list_file
#
##########

function make_index_file_header() {

	iconv -f CP932 -t UTF-8 <<-EOL > "${download_list_file}"
<!DOCTYPE html>
<html lang="ja">
<head>
<title>ConcertoDownload Link List</title>
</head>
<body>
<h1>ConcertoDownload Link List</h1>
<dl id='link_list'>
EOL

}

##########
#	DLファイルリストfooter行作成
#
#	@global download_list_file
#
##########

function make_index_file_footer() {
	iconv -f CP932 -t UTF-8 <<-EOL >> "${download_list_file}"
</dl>
</body>
</html>
EOL

}

##########
#	DLファイルリストanchor行作成
#
#	@global download_list_file
#	@param href
#	@param text
#
##########

function make_index_file_anchor() {
	iconv -f CP932 -t UTF-8 <<-EOL >> "${download_list_file}"
	<dd><a href='${download_list_link}${1}' target="_blank">${2}</a></dd>
EOL

}

##########
#	DLファイルリストanchorタイトル行作成
#
#	@global download_list_file
#	@param text
#
##########

function make_index_file_anchor_title() {
	iconv -f CP932 -t UTF-8 <<-EOL >> "${download_list_file}"
	<dt>${1}</dt>
EOL

}

##########
#	URL定義ファイルPATH 確認
#
#	@param path
#	@notice 31
#
##########

function check_config_file() {
	[[ ! -f "$1" ]] && \
		echo && \
		echo "config file not found=${1}" && \
		echo && \
		return 31
	
	return 0
}

##########
#	保存ファイル名作成
#
#	@global user_dir
#	@param url
#	@return save_dir
#
##########

function create_save_file_path() {
	#URL分割
	local -a splited_urls
	IFS=/ read -a splited_urls <<<"${1}"
	
	local -i max_no=$((${#splited_urls[@]} - 1))
	local save_file_path="${user_dir}"
	local -i i

	for (( i=0; i<${max_no}; i++ ));
	do
		save_file_path="${save_file_path}/${splited_urls[${i}]}"
	done

	echo "${save_file_path}/${splited_urls[${max_no}]/\?/_}"
}

##########
#	保存ファイル名作成
#
#	@param save_dir
#
##########

function create_save_dir() {
	local dir=$(dirname "${1}")
	
	[[ -z "${dir}" ]] && <<EOL && exit 23

	firure create dir

EOL

	mkdir -p "${dir}"

}

##########
#	ファイルダウンロード
#
#	@global cookie_file
#	@param url
#	@param save_file
#
##########

function download_file() {
	local progress=$'\s'
	
	curl \
		-k \
		-c "${cookie_file}" \
		-b "${cookie_file}" \
		"${progress}" \
		"${1}" \
		> "${2}"
}

##########
#	EXCELファイル拡張子作成
#
#	@param ダウンロードファイルパス
#	@return 拡張子
#
##########

function resolveExcelFileExt() {
	local macro_row=$( \
		unzip -p "${1}" '\[Content_Types\]\.xml' | \
		grep -i 'macroEnabled'
	)
	
	if [[ -z ${macro_row} ]] ;
	then
		echo .xlsx
	else
		echo .xlsm
	fi
}

##########
#	ファイルパス拡張子追加
#
#	@global config_exts
#	@param ダウンロードファイルパス
#	@return 拡張子付きファイルパス
#
##########

function add_ext_to_file_path() {
	local mime=$( \
		file --mime "${1}" | \
			cut -d\  -f 2
	)
	
	local ext="${config_exts[${mime}]}"
	
	if [[ ${ext} == .xlsx ]];
	then
		ext=$(resolveExcelFileExt "${1}")
	fi
	
	local new_save_file="${1/\?/_}${ext}"
	
	mv "${save_file}" "${new_save_file}"
	
	echo "${new_save_file}"
}

##########
#	DLファイルリストanchor URL作成
#
#	@global user_dir
#	@param 拡張子付きファイルパス
#	@return URL
#
##########

function create_url_from_file_path() {
	echo "${1#${user_dir}/}"
}

##########
#	イメージURL検索
#
#	@param save_file
#	@return tracing_link_list
#
##########

function search_images() {
	grep "<img" "${1}" | \
		sed -r 's/^.+ src="(.+)".+$/\1/'
}

##########
#	追跡imgリンク解決
#
#	@global base_url
#	@param url
#	@param tracing_url
#	@return recursive_link_url
#
##########

function create_image_url() {
	if [[ ${2} =~ ^http ]];
	then
		echo "${1}"
		return 0
	fi
	
	#URL分割
	local -a splited_urls
	IFS=/ read -a splited_urls <<<"${1}"

	#相対親url
	parent_url="${splited_urls[-2]}"
	
	if [[ $2 =~ ^\./ ]];
	then
		echo "${parent_url}${2/\./}"
		return 0
	elif [[ $2 =~ ^\/ ]];
	then
		echo "${parent_url}${2}"
		return 0
	fi
	
	echo "${parent_url}/${2}"
	
}

##########
#	リンク追跡
#
#	@param parent_url
#	@param save_file
#	@notice 41
#
##########

function recursive_links() {
	###################
	#チャートのみimg抽出
	###################
	[[ ! "$2" =~ _chart_ ]] && return 41
	
	#img src取得
	local -a tracing_link_list=($(search_images "${2}"))
	
	#imgダウンロード
	local tracing_url
	local image_url
	
	for tracing_url in "${tracing_link_list[@]}";
	do 
		image_url=$(create_image_url "${1}" "${tracing_url}")
		download_from_config_url "${image_url}" ''
	done
}

##########
#	定義URLからダウンロード
#
#	@global base_url
#	@global cookie_file
#	@global link_url
#	@param config_url 定義URL
#
##########

function download_from_config_url() {
	#相対URLを絶対URLに変換
	local url="${base_url}${1}"
	
	#保存ファイル名作成
	# local save_file=$(create_save_file_path "${1}" "${2}")
	local save_file=$(create_save_file_path "${1}")
	
	#保存先dir作成
	create_save_dir "${save_file}"

	#message
	print_message
	print_message "${url}"
	print_message "${save_file}"
	
	#ファイルダウンロード
	download_file "${url}" "${save_file}"

	#ファイルパス拡張子追加
	local new_save_file=$(add_ext_to_file_path "${save_file}")
	
	#DLファイルリストanchor URL作成
	local link_url=$(create_url_from_file_path "${new_save_file}")
	
	#DLファイルリストanchor行作成
	make_index_file_anchor \
		"${link_url}" \
		"${1}"
	
	#リンク追跡
	if [[ ${new_save_file} =~ .htm$ ]] ;
	then
		recursive_links "${url}" "${new_save_file}"
	fi
}

##########
#	URL定義配列からダウンロード
#
#	@global config_file_path
#
##########

function download_from_configs() {
	#URL定義ファイルPATH 確認
	check_config_file "${config_file}"

	#URL定義ファイル読み込み
	local -a config=($(cat "${config_file}"))

	local target_url
	
	#ダウンロード
	for target_url in "${config[@]}"
	do
		#コメント行
		if [[ ${target_url} =~ ^# ]];
		then
			make_index_file_anchor_title ${target_url:1}
		else
			download_from_config_url "${target_url}"
		fi
	done

	#message
	print_message
}

##########
#	main
#
#	@param script_arguments
#
##########

function main() {
	#引数確認
	check_arguments "$@"

	#パスワード入力
	input_password

	#作業DIR作成
	create_work_dir

	#初期アクセス
	init_access

	#CQRS token取得
	local -r token="$(get_cqrs_token ${work_file})"

	#CQRS token確認
	check_cqrs_token "${token}"

	#認証
	authenticate "${token}"

	#DLファイルリストheader行作成
	make_index_file_header

	#URL定義ファイルからダウンロード
	download_from_configs

	#DLファイルリストfooter行作成
	make_index_file_footer
}

main "${@}"

