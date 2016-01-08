FROM ubuntu:12.04
MAINTAINER tommi2day

#env
ENV DEBIAN_FRONTEND noninteractive
ENV HOSTNAME mysql4
ENV TZ Europe/Berlin
ENV TERM linux
ENV PATH /usr/local/mysql/bin:$PATH

RUN apt-get update 
RUN apt-get install -q -y build-essential libncurses5-dev bison less vim

#locale
RUN locale-gen de_DE.UTF-8 && locale-gen en_US.UTF-8 && dpkg-reconfigure locales 
#Time
RUN echo "$TZ" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

#add mysql user and sources
RUN groupadd -r mysql && useradd -r -g mysql mysql

#compile mysql4 from source
COPY compile_mysql4.sh mysql-4.1.25.tar.gz /root/
RUN chmod +x /root/compile_mysql4.sh
RUN /root/compile_mysql4.sh

#add entrypoint
COPY start.sh stop_mysql.sh /root/
RUN chmod +x /root/*.sh

#interfaces
EXPOSE 3306
VOLUME /db

#define entrypoint
ENTRYPOINT ["/root/start.sh"]
CMD ["mysqld_safe"]
