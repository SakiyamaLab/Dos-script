server_ip="192.168.20.226"
port="12345"
arg1=$1
arg2=$2
file=$3
device_num=$4
client_ip=$(./get_ip.sh)
client_serial=$(./serial.sh)
echo "serial = $client_serial"
for (( i=$arg1+$device_num - 1; i<=$arg2; i+=5 )); do
	started_at=$(date +'%s.%3N')
	"/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "insert into sensorNormal(id, hostname, fixedid, payload, ctime) values($i, '$client_ip', '$client_serial', '$(./random.sh)', '$(./timestamp.sh)')"
	"/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "update sensorNormal set stime='$(./timestamp.sh)' where id=$i"
	ended_at=$(date +'%s.%3N')
	elapsed=$(echo "scale=3; $ended_at - $started_at" | bc)
	echo "$(date +'%H:%M:%S'),$elapsed" >> $file
done

# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "select * from sensorNormal"
# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "delete from test"

exit 0
