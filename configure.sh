#!/bin/sh
# Download and install V2Ray
wget -q -O xray.zip http://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
mkdir /usr/bin/Xray /etc/Xray
touch /etc/Xray/config.json
unzip /xray.zip -d /usr/bin/Xray
# Remove /v2ray.zip and other useless files
rm -rf /xray.zip /usr/bin/Xray/LICENSE /usr/bin/Xray/*.md /usr/bin/Xray/*.dat
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
          "alterId": 0
        }
      ]
    },
     "fallbacks": [
            {
                "dest": "process.glaorg.top:443" // 或者回落到其它也防探测的代理
            }
        ]
    },
    "streamSettings": {
      "network": "ws",
      "security":"auto",
    "wsSettings": {
        "path": "${path}"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF
chmod +x /usr/bin/Xray/xray
/usr/bin/Xray/xray -config=/etc/Xray/config.json
