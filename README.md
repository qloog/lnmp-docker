# Run Under Mac

## 环境要求

- Homebrew
- VirtualBox
- git

### install brew

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install wget
```

### install virtualbox

```
brew tap caskroom/cask  // 添加 Github 上的 caskroom/cask 库
brew install brew-cask  // 安装 brew-cask
brew cask install  VirtualBox // 安装 VirtualBox，保存到：/opt/homebrew-cask/Caskroom
```

### Git: 确保Xcode已经安装

## 安装Docker基础环境(Docker/Docker-Machine/Docker-Compose)

```
brew tap homebrew/binary
brew install docker -vvv
brew install docker-machine -vvv
brew install docker-compose -vvv
```

安装docker-machine，会下载Boot2docker，默认会从AWS下载镜像，此处需要翻墙
如果无法翻墙可以手动下载Boot2Docker所需ISO镜像

## 创建虚拟机
```
docker-machine create --driver virtualbox default
```

运行Docker需要设置环境变量，建议在~/.bashrc(或.zshrc)中加入

```
if [ "`docker-machine status`" = "Running" ]; then
    eval $(docker-machine env default)
fi
```

## 创建APP需要的基础容器：系统（Ubuntu）

```
docker run ubuntu:14:04
```

## 启动Laravel5-backend

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

下载镜像及构建

```
make dl
make build
```

构建及运行环境

```
docker-compose build
docker-compose up
```

绑定域名

```
sudo vi /etc/hosts
加入
192.168.99.100 docker
```

现在可以通过访问`http://docker/`来查看Web服务器根目录


构建项目文件

```
cd ~/opt/htdocs
git clone https://github.com/qloog/laravel5-backend.git
cd laravel5-backend
make install
```
