#!/bin/sh
# Download and install V2Ray
curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
mkdir /usr/bin/Xray /etc/Xray
touch /etc/Xray/config.json
unzip /v2ray.zip -d /usr/bin/Xray
# Remove /v2ray.zip and other useless files
rm -rf /Xray.zip /usr/bin/Xray/LICENSE /usr/bin/Xray/*.md 
# V2Ray new configuration
cat <<-EOF > /etc/Xray/config.json
{
  "inbounds": [
  {
    "listen": "0.0.0.0",
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 64
        }
      ]
    },
    "streamSettings": {
      "network": "ws",
      "security":"auto",
    "wsSettings": {
        "path": "/"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
        "tag": "block",
        "protocol": "blackhole"
    },
    ],
    "routing": {
    "domainStrategy": "AsIs",
    "rules": [
        {
            "type": "field",
            "domain": [
                "doubleclick.net",
                "pincong.rocks"
                ],
            "outboundTag": "block"
            ]
        },
  ]
}
EOF
chmod +x /usr/bin/Xray/xray
/usr/bin/Xray/xray -config=/etc/Xray/config.json
