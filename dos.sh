server_ip="192.168.20.226"
port="12345"
device=$3
arg1=$1
arg2=$2
client_ip=$(./get_ip.sh)
client_serial=$(./serial.sh)
random_chara=$(./random.sh)
timestamp=$(./timestamp.sh)
echo "serial = $client_serial"
for i in $(seq ${arg1} ${arg2}); do
	sleep 0.1
	"/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://$server_ip:$port" --exec "insert into sensorNormal values($i, '$client_ip', '$client_serial', '$random_chara', '$timestamp')"
done

"/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "select * from sensorNormal"
# "/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "delete from test"

exit 0
