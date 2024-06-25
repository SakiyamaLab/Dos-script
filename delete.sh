server_ip="192.168.20.226"
port="12345"
device=$1
"/home/raspberrypi${device}/Develop/lab/db/tsurugi-sql/tgsql-1.3.0/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "delete from sensorNormal"

exit 0
