ip -4 addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
