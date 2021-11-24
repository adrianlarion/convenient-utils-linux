#!/bin/bash
# Find all broken symbolic links
# Works for broken links containing: spaces, colons, etc. 
usage(){
	echo "${0##*/} [-d|--dir <dirname>]"
}
dir=
while [[ -n $1 ]]; do 
	case $1 in 
		-d | --dir) shift 
			dir=$1
			;;
		*) usage >&2
			exit 1
			;;
	esac
	shift
done
# defaults
if [ -z $dir ]; then dir=.; fi
# fix dir
if [[ "$dir" == '.' ]]; then dir=$(pwd); fi
if ! [[ "$dir" =~ .*/$ ]]; then dir="$dir"/ ; fi
# The work
# Use temp file otherwise hard to deal with spaces, newlines, colons, etc

temp_file=$(mktemp)
all_res=$(find "$dir" -type l  -print0 2>/dev/null| xargs -0 file -0 > "$temp_file" )
# cat $temp_file | egrep '.* broken symbolic link to' | cut -f1 -d ''

broken_lines_num=$(cat $temp_file| cut -d '' -f2 | grep -n '.* broken symbolic link to' | cut -f1 -d: )
# for line_num in $broken_lines_num; do sed -n "${line_num}p" $temp_file; done | cut -f1 -d '' 
for line_num in $broken_lines_num; do sed -n "${line_num}p" $temp_file; done | cut -f1 -d '' 

# for line_num in $broken_lines_num; do awk "NR==$line_num{print}" $temp_file | cut -d '' -f1 ; done
#rm temp
if [ -e $temp_file ]; then rm "$temp_file"; fi




