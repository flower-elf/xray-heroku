#!/bin/sh
# Download and install xray
wget -q -O xray.zip http://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
mkdir /usr/bin/Xray /etc/Xray
touch /etc/Xray/config.json
unzip /xray.zip -d /usr/bin/Xray
# Remove /xray.zip and other useless files
rm -rf /xray.zip /usr/bin/Xray/LICENSE /usr/bin/Xray/*.md /usr/bin/Xray/*.dat
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
