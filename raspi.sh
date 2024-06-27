#!/bin/bash

# started timestamp
date=$(date +'%Y-%m-%d_%H:%M:%S')

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

# 計算式を関数化する
calculate_start_end () {
    local start=$(( $1 / $2 * ($3 - 1) + 1 ))
    local end=$(( $1 / $2 * $3 ))
    echo "$start $end"
}

# 任意の数の並列処理を実行する
num_processes=$2
echo "processes = $num_processes"

# CSVファイルのヘッダを追加
file="${date}_loop${1}_processes${2}.csv"
echo "timestamp,elapsed_time" > $file

for (( i=1; i<=$num_processes; i++ )); do
    # 計算式を呼び出してstartとendを取得
    read start end <<< $(calculate_start_end $1 $num_processes $i)

    echo "start = $start end = $end"
    ./dos.sh $start $end "$date" $device_num &
done

# 全てのバックグラウンドジョブが完了するまで待機
wait

echo "All processes completed."
