server_ip="localhost"
port=12345
"/usr/lib/tsurugi-snapshot-202406161046-c5d76ff/bin/tgsql" -c "tcp://${server_ip}:${port}" --exec "select count(*) from sensorNormal"

exit 0
