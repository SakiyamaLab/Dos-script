#!/bin/bash

# See http://unix.stackexchange.com/questions/101080/realpath-command-not-found
realpath ()
{
    f=$@;
    if [ -d "$f" ]; then
        base="";
        dir="$f";
    else
        base="/$(basename "$f")";
        dir=$(dirname "$f");
    fi;
    dir=$(cd "$dir" && /bin/pwd);
    echo "$dir$base"
}

# generation help
function usage {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h          Display help
  -f file     file name of file path
  -l num      loop times
EOM

  exit 2
}

Dos ()
{
    start=$(( $1 * ($2 - 1) + 1 ))  # startを計算する式
    end=$(( $1 * $2 ))          # endを計算する式
    device=$2
    ./dos.sh $start $end $dvice
}

select_device () {
	device=$1
	case $device in
		*1*)
			echo 1
			;;
		*2*)
			echo 2
			;;
		*3*)
			echo 3
			;;
		*4*)
			echo 4
			;;
		*5*)
			echo 5
			;;
		*)
			echo 0
			;;
	esac
}


# 引数別の処理定義
while getopts ":l:d:h" optKey; do
  case "$optKey" in
    l)
      	loop_time=$OPTARG
      	echo "loop time = ${loop_time}"
      	;;
    d)
	device=$(select_device $OPTARG)  # select_device の結果を数値で取得
        if [ $device -eq 0 ]; then
  		echo "Error: out of range of 1 to 5"
                exit 1
	fi
        echo "device = raspi${device}"
        ;; 
  esac
done


Dos $loop_time $device
