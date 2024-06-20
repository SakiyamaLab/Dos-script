ip="192.168.20.226"
port="12345"
device=$3
arg1=$1
arg2=$2
for i in $(seq ${arg1} ${arg2}); do
	sleep 0.1
	"/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$ip:$port" --exec "insert into test values($i, 'Im raspberrypi$3')"
done

"/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${ip}:${port}" --exec "select * from test"
# "/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${ip}:${port}" --exec "delete from test"

exit 0
