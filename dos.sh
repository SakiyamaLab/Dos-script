server_ip="192.168.20.226"
port="12345"
file=$1
device_num=$2
client_ip=$(./get_ip.sh)
client_serial=$(./serial.sh)
id=$$
echo "serial = $client_serial"

total_seconds=300
interval=$3
seconds_passed=0
while true; do
	if [ $seconds_passed -ge $total_seconds ]; then
		break
	fi
	started_at=$(date +'%s.%3N')
	"/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "insert into sensorNormal(id, hostname, fixedid, payload, ctime) values($id, '$client_ip', '$client_serial', '$(./random.sh)', '$(./timestamp.sh)')" &
	"/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "update sensorNormal set stime='$(./timestamp.sh)' where id=$id" &
	ended_at=$(date +'%s.%3N')
	elapsed=$(echo "scale=3; $ended_at - $started_at" | bc)
	echo "$(date +'%H:%M:%S.%3N'),$elapsed" >> $file

	id=$id+1

	# 経過時間を更新
    	seconds_passed=$((seconds_passed + interval))
	sleep $interval
done

# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "select * from sensorNormal"
# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "delete from test"

exit 0
