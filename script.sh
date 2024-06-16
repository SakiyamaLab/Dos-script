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
    ip="localhost"
    port="12345"
    start=$1
    end=$2
    device=$3
    ./dos.sh $start $end $dvice
}


# 引数別の処理定義
while getopts ":f:l:d:h" optKey; do
  case "$optKey" in
    f)
      file_path=$(realpath ${OPTARG})
      echo "file = ${file_path}"
      ;;
    l)
      loop_time=$OPTARG
      echo "loop time = ${loop_time}"
      ;;
    d)
      device=$OPTARG
      echo "device = raspi${device}"
      ;;
    '-h'|'--help'|* )
      usage
      ;;
  esac
done


Dos 
