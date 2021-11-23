#!/bin/bash
# How much space each user occupies in dir
help(){
	echo "Usage: $0  [-u <username>] [-d <dirname>] [-h] [-s]"} 
	echo -e "Available options: \n
		-u  Username for which to calculate space usage. Default current user.
		-d  Dir to perform analysis. Default '.'
		-k  Show in Kibibytes without any unit of measure (like 'du'). By default it will show something like '1.5 MiB'
		-s  Force silent (no verbose). Default OFF.
		" 
	}
user_exists(){
	grep "^${1}:" /etc/passwd 1>/dev/null && return 0
	return 1
}

convert_to_h(){
	res=$1
	if (($1 < 1024)); then 
		res=$( echo "$1" | awk '{  printf "%.2f KiB",$1}');
	elif (($1 >=1024)); then
		res=$( echo "$1" | awk '{ $1/=1024; printf "%.2f MiB",$1}');
	elif (($1 >=1048576)); then
		res=$( echo "$1" | awk '{ $1/=1024; printf "%.2f GiB",$1}');
	elif (($1 >=1073741824)); then
		res=$( echo "$1" | awk '{ $1/=1024; printf "%.2f TiB",$1}');
	elif (($1 >=1099511627776)); then
		res=$( echo "$1" | awk '{ $1/=1024; printf "%.2f PiB",$1}');
	fi
	echo $res
}

# Wrapper otherwise when called with empty stdin du will calc all files in dir
du_wrap(){
	if [ -z $1 ]; then echo ""
	else
		du "$1"
	fi
}
# export function otherwise unavailable to xargs
export -f du_wrap



while getopts ":u:d:ks" opts; do
	case "${opts}" in 
		u)
			u=${OPTARG}
			if ! user_exists $u;
			then echo "user '$u' doesn't exist " >&2; exit 1
			fi
			;;
		d)
			d=${OPTARG}
			if ! [ -d "$d" ];
			then echo "'$d' Doesn't exist or it's not a dir" >&2; exit 1
			fi
			;;
		k)
			k=1
			;;
		s)
			s=1
			;;

		:)
			echo "-${OPTARG} requires an argument" >&2; exit 1
			;;
		*)
			help; exit 0
			;;




	esac
done
set defaults
d=${d:=.}
u=${u:=$(whoami)}
if ! [[ $s == 1 ]]; then 
	echo "Searching files for user '$u' in dir '$d'. Please wait, this might take a wile ..."
fi

# show result
if ! [[ $s == 1 ]];then 
echo DONE
fi

# totalkb=$(find "$d" -user "$u" -type f -print0 |  xargs --null -n1 $(du_wrap)| cut -f1 | awk 'BEGIN {totalkb=0} {totalkb+=$1} END {print totalkb}' )
# find "$d" -user "$u" -type f -print0 |  xargs --null -L 1  bash -c 'du_wrap "$@"' _ 
# find "$d" -user "$u" -type f -print0 |  xargs --null n1 ${du_wrap}
	# Print human readable
	# if ! [[ $k == 1 ]]; then
	# 	echo  $(convert_to_h $totalkb)
	# else 
	# 	echo $totalkb 
	# fi


