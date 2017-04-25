
## Install

### 1. Docker for Mac (Recommend)

Docker Native

直接下载官方dmg文件安装

link: [Getting Started with Docker for Mac](https://docs.docker.com/docker-for-mac/)


### 2. Docker based on VirtualBox VM

> 适用于旧版本，现在直接安装官方原生包即可。

<details>

#### requirement

- Homebrew
- VirtualBox
- Git

#### install brew

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install wget
```

#### install virtualbox

```
brew tap caskroom/cask  // 添加 Github 上的 caskroom/cask 库
brew install brew-cask  // 安装 brew-cask
brew cask install  VirtualBox // 安装 VirtualBox，保存到：/opt/homebrew-cask/Caskroom
```

#### xcode

```
xcode-select --install  # 弹窗提示后，点击“安装”即可
```

#### Git

```
brew install git
```
> 安装xcode后，git会被默认安装，如果已安装可忽略

#### Docker environment (Docker/Docker-Machine/Docker-Compose)

```
brew tap homebrew/binary
brew install docker -vvv
brew install docker-machine -vvv
brew install docker-compose -vvv
```

> 安装docker-machine，会下载Boot2docker，默认会从AWS下载镜像，此处需要翻墙
> 如果无法翻墙可以手动下载Boot2Docker所需ISO镜像,下载地址：https://github.com/boot2docker/boot2docker/releases/
> 找到对应的 release 的boot2docker.iso 文件，放入~/.docker/machine/cache 目录里
> cd ~/.docker/machine/cache  && wget https://github.com/boot2docker/boot2docker/releases/download/v1.11.0/boot2docker.iso

#### Create Virtual machine default

也可以是其他名字，比如 dev, docker-vm, 这里用默认的default

```
docker-machine create --driver virtualbox default
```

#### Link to Virtual machine

运行Docker需要设置环境变量
```
eval $(docker-machine env default)
```

建议在~/.bashrc(或.zshrc)中加入

```
if [ "`docker-machine status`" = "Running" ]; then
    eval $(docker-machine env default)
fi
```
</details>

## About docker

 * [Docker是什么](https://www.docker.com/whatisdocker/)
 * [Docker命令行的基础使用](https://docs.docker.com/userguide/)


## Launch Laravel5-backend

准备基础的目录，由于Mac下默认允许挂载/Users/的文件，因此本套方案将系统文件挂载位置强制设置为`~/opt/`

- ~/opt/data   存放MySQL数据库，Elastic数据
- ~/opt/htdocs 项目代码
- ~/opt/log    存放所有输出Log

创建这些目录:

```
mkdir ~/opt ~/opt/data ~/opt/data/mysql ~/opt/data/elasticsearch ~/opt/log ~/opt/log/nginx ~/opt/log/php ~/opt/htdocs
```

Clone本项目

```
cd ~/opt/htdocs
git clone https://github.com/qloog/Dockerfiles.git
cd Dockerfiles
```

下载php扩展包及构建镜像

```
make dl
```

构建及运行环境

```
docker-compose build
docker-compose up or docker-compose up -d
```

登录到镜像服务器

```
docker run -i -t <IMAGE_ID> /bin/bash

```

如何修改配置文件

 - login into nginx image:

```
docker run -i -t dockerfiles_nginx /bin/bash
vim /etc/nginx/conf.d/default.conf
```
 - login into php image:

```
docker run -i -t dockerfiles_php /bin/bash
vim /usr/local/etc/php/php.ini
```
 - login into mysql image:

```
docker run -i -t dockerfiles_mysql /bin/bash
vim /usr/local/etc/php/php.ini
```


绑定域名(Docker for Mac 不需要执行该操作)

```
sudo vi /etc/hosts
加入
192.168.99.100 docker
```
IP可通过`curl $(docker-machine ip default):8080` 来查看

现在可以通过访问`http://docker:8080/`来查看Web服务器根目录


构建项目文件

```
cd ~/opt/htdocs
git clone https://github.com/qloog/laravel5-backend.git
cd laravel5-backend
make install
```

## Reference

 * http://avnpc.com/pages/build-php-develop-env-by-docker
 * https://vincent.composieux.fr/article/run-a-symfony-application-using-docker-and-docker-compose
