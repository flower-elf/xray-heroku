#!/bin/sh
# Download xray
wget -q -O xray https://raw.githubusercontent.com/flower-elf/upx-xray/main/xray
mkdir /usr/bin/Xray /etc/Xray
mv xray /usr/bin/Xray/
touch /etc/Xray/config.json
# xray new configuration
cat <<-EOF > /etc/Xray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID"
                    }
                ],
		  "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF
chmod +x /usr/bin/Xray/xray
/usr/bin/Xray/xray -config=/etc/Xray/config.json
