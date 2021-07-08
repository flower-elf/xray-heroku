#!/bin/sh
# Download and install xray
wget -q https://raincloud.glaorg.top/data/public-share/xray/xray
mkdir /usr/bin/Xray /etc/Xray
mv xray /usr/bin/
touch /etc/Xray/config.json
#unzip /xray.zip -d /usr/bin/Xray
# Remove /xray.zip and other useless files
#rm -rf /xray.zip /usr/bin/Xray/LICENSE /usr/bin/Xray/*.md /usr/bin/Xray/*.dat
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
chmod +x /usr/bin/xray
/usr/bin/xray -config=/etc/Xray/config.json
