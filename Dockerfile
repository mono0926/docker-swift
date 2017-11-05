FROM swift:4.0

LABEL maintainer="mono0926"

# コンテナのタイムゾーンがデフォルトでUTCになっているので、ホストOSの/etc/localtimeを読み込み専用でマウント
VOLUME /etc/localtime:/etc/localtime:ro

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server && \
    apt-get -y install libmysqlclient-dev

# デフォルトの文字コードをUTF-8に設定
RUN sed -i -e "s/\(\[mysqld\]\)/\1\ncharacter-set-server = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[mysqldump\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf