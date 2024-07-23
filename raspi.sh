#!/bin/bash

# started timestamp
date=$(date +'%Y-%m-%d_%H:%M:%S')

# 引数が渡されていない場合のエラーメッセージ
if [ $# -eq 0 ]; then
    echo "Usage: $0 <processes> <interval time>"
    exit 1
fi

select_device () {
    local host=$1
    case $host in
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

hostname=$(hostname)
device_num=$(select_device "$hostname")
echo "device = $device_num"


# 任意の数の並列処理を実行する
num_processes=$1
echo "processes = $num_processes"

# CSVファイルのヘッダを追加
file="${date}_interval${2}s_processes${1}_$(whoami).csv"
echo "timestamp,elapsed_time" > $file

# interval time
sleep_time=$2

for (( i=1; i<=$num_processes; i++ )); do
    ./dos.sh $file $device_num $sleep_time&
done

# 全てのバックグラウンドジョブが完了するまで待機
wait

echo "All processes completed."
