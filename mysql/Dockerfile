ARG MYSQL_VERSION
FROM mysql:${MYSQL_VERSION}

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

#####################################
# Install XtraBackup
#####################################

RUN apt-get update && apt-get install -y lsb-release \
    && apt-get install -y curl \
    && apt-get install --no-install-recommends -y wget \ 
    && apt-get install -y ca-certificates \
    && wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb \
    && dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb \
    && apt-get update \
    && apt-get install -y percona-xtrabackup-80

#####################################
# Install Nano
#####################################

RUN apt-get install -y nano

#####################################
# Install AWS CLI
#####################################

RUN apt-get update && apt-get install -y awscli

#####################################
# Add Config
#####################################

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod 0444 /etc/mysql/conf.d/my.cnf

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_ADD_CONFIG

RUN if [ ${MYSQL_ADD_CONFIG} = true ]; then \
    echo [client] >> /etc/mysql/conf.d/my.cnf \
    && echo user=root >> /etc/mysql/conf.d/my.cnf \
    && echo password="'$MYSQL_ROOT_PASSWORD'" >> /etc/mysql/conf.d/my.cnf \
;fi

#####################################
# Add Scripts
#####################################

RUN mkdir /opt/scripts

COPY backup.sh /opt/scripts/backup.sh

RUN ln -s /opt/scripts/backup.sh /usr/local/bin/



CMD ["mysqld"]

EXPOSE 3306