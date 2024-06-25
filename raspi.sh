#!/bin/bash

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

hostname=$(hostname)
device=$(select_device $hostname)
echo "device = $device"

start1=$(( $1 * ($device - 1) + 1 ))  		# startを計算する式
end1=$(( $1 * $device / 5 * 1 ))          	# endを計算する式
start2=$(( $1 * ($device - 1) + 1 + $end1 )) 	# startを計算する式
end2=$(( $1 * $device / 5 * 2 ))        	# endを計算する式
start3=$(( $1 * ($device - 1) + 1 + $end2 ))  	# startを計算する式
end3=$(( $1 * $device / 5 * 3 ))          	# endを計算する式
start4=$(( $1 * ($device - 1) + 1 + $end3 ))  	# startを計算する式
end4=$(( $1 * $device / 5 * 4 ))          	# endを計算する式
start5=$(( $1 * ($device - 1) + 1 + $end4 ))  	# startを計算する式
end5=$(( $1 * $device ))          		# endを計算する式

echo "start = $start1 end = $end1"
./dos.sh $start1 $end1 $device &
echo "start = $start2 end = $end2"
./dos.sh $start2 $end2 $device &
echo "start = $start3 end = $end3"
./dos.sh $start3 $end3 $device &
echo "start = $start4 end = $end4"
./dos.sh $start4 $end4 $device &
echo "start = $start5 end = $end5"
./dos.sh $start5 $end5 $device &
