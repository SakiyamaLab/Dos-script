server_ip="192.168.20.226"
port="12345"
arg1=$1
arg2=$2
client_ip=$(./get_ip.sh)
client_serial=$(./serial.sh)
echo "serial = $client_serial"
for i in $(seq ${arg1} ${arg2}); do
	"/home/$(whomai)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "insert into sensorNormal(id, hostname, fixedid, payload, ctime) values($i, '$client_ip', '$client_serial', '$(./random.sh)', '$(./timestamp.sh)')"
	"/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "update sensorNormal set stime='$(./timestamp.sh)' where id=$i"
done

# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "select * from sensorNormal"
# "/home/$(whoami)/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "delete from test"

exit 0
