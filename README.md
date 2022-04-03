# Xray Heroku

## 概述

用于在 Heroku 上部署 Xr Websocket。

**Heroku 为我们提供了免费的容器服务，我们不应该滥用它，所以本项目不宜长期使用。**

**可以部署两个以上的应用，实现[负载均衡](https://toutyrater.github.io/app/balance.html)


## 镜像

本镜像仅 6MB，比起其他用于 Heroku 的 Xray 镜像，不会因为大量占用资源而被封号。

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/flower-elf/xray-heroku/)

## ENV 设定

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。

`path` > `连接路径，用于隐藏`。


## 注意

WebSocket 默认路径为 /。（支持0-rtt,可自定义）

AlterID 为 0。

将在部署时自动安装最新版本。

**出于安全考量，除非使用 CDN，否则请不要使用自定义域名，而使用 Heroku 分配的二级域名，以实现 Websocket + TLS+0rtt。**
