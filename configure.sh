#!/bin/sh

wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /root/cloudflared
chmod +x /root/cloudflared
# Download xray
wget -q -O xray https://raw.githubusercontent.com/flower-elf/upx-xray/main/xray
mkdir /usr/bin/Xray /etc/Xray
mv xray /usr/bin/Xray/
touch /etc/Xray/config.json
# xray new configuration
cat <<-EOF > /etc/Xray/config.json
{
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field",
                "domain": [
                    "domain:t66y.com"
                ],
                "outboundTag": "block"
            },
	    {
               "type": "field",
               "protocol": [
                "bittorrent"
               ],
               "outboundTag": "block"
            }
        ]
    },
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
                "network": "ws",
		"wsSettings": {
                   "path": "${path}"
            }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        },
	{
            "tag": "block",
            "protocol": "blackhole"
        }
    ]
}
EOF
chmod +x /usr/bin/Xray/xray
if [[ $TUNNEL_TOKEN ]]; then
echo 'has tunnel token, run cloudflared tunnel'
/usr/bin/Xray/xray -config=/etc/Xray/config.json & /root/cloudflared tunnel --no-autoupdate run --token $TUNNEL_TOKEN
else
/usr/bin/Xray/xray -config=/etc/Xray/config.json
fi
