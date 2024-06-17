ip="192.168.20.226"
port="12345"
device=$3
arg1=$1
arg2=$2
for i in $(seq ${arg1} ${arg2}); do
	sleep 0.1
	/usr/lib/tsurugi-snapshot-202406161046-c5d76ff/bin/tgsql -c "tcp://$ip:$port" --exec "insert into test values($i, 'Im raspberrypi$3')"
done

/usr/lib/tsurugi-snapshot-202406161046-c5d76ff/bin/tgsql -c "tcp://${ip}:${port}" --exec "select * from test"
/usr/lib/tsurugi-snapshot-202406161046-c5d76ff/bin/tgsql -c "tcp://${ip}:${port}" --exec "delete from test"

exit 0
