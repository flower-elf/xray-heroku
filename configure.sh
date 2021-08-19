#!/bin/sh
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
                    "domain:t66y.com",
		    "domain:epochtimes.com",
		    "domain:minghui.org",
		    "domain:pincong.rocks",
		    "domain:dw.com",
		    "domain:rfa.org",
		    "domain:doubleclick.net",
		    "domain:360.cn",
		    "regexp:(.?)(xunlei|sandai|Thunder|XLLiveUD)(.)",
		    "regexp:(api|ps|sv|offnavi|newvector|ulog\.imap|newloc)(\.map|)\.(baidu|n\.shifen)\.com"
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
                "network": "ws"
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
/usr/bin/Xray/xray -config=/etc/Xray/config.json
