list:
	@echo "pull"
	@echo "dl"
	@echo "build"

pull:
	docker pull nginx:1.9.0
	docker pull php:5.6-fpm
	docker pull mysql:5.6
	docker pull redis:3.0
	docker pull memcached:1.4
	docker pull node:0.12

dl:
	wget https://github.com/phalcon/cphalcon/archive/1.3.5.tar.gz -O php/cphalcon.tgz
	wget https://pecl.php.net/get/yaf-3.0.7.tgz -O php/yaf.tgz
	wget https://pecl.php.net/get/gearman-1.1.2.tgz -O php/gearman.tgz
	wget https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/msgpack-0.5.6.tgz -O php/msgpack.tgz
	wget https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://getcomposer.org/composer.phar -O php/composer.phar

build:
	make build-nginx
	make build-mysql
	make build-php


build-nginx:
	docker build -t local/nginx ./nginx

run-nginx:
	docker run -i -d -p 8088:80 -v ~/opt:/opt -t -d local/nginx

in-nginx:
	docker run -i -p 8088:80 -v ~/opt:/opt -t local/nginx /bin/bash

build-php:
	docker build -t local/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/opt:/opt -t local/php

in-php:
	docker run -i -p 9000:9000 -v ~/opt:/opt -t local/php /bin/bash

build-mysql:
	docker build -t local/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t local/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t local/mysql /bin/bash

build-node:
	docker build -t local/node ./node

run-node:
	docker run -i -d -p 8001:8001 -v ~/opt:/opt -t local/node

in-node:
	docker run -i -p 8001:8001 -v ~/opt:/opt -t local/node /bin/bash

build-elasticsearch:
	docker build -t local/elasticsearch ./elasticsearch

run-elasticsearch:
	docker run -i -d -p 9200:9200 -p 9300:9300 -v ~/opt/data/elasticsearch:/usr/share/elasticsearch/data -t local/elasticsearch

in-elasticsearch:
	docker run -i -p 9200:9200 -p 9300:9300 -v ~/opt/data/elasticsearch:/usr/share/elasticsearch/data -t local/elasticsearch /bin/bash

build-gearman:
	docker build -t local/gearman ./gearman

run-gearman:
	docker run -d -p 4730:4730 -v ~/opt:/opt -it local/gearman

clean:
	docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
