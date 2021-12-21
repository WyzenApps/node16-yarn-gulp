ARG NODE_VERSION=16-slim
FROM node:$NODE_VERSION
LABEL Description="Node 16, Yarn 3, Gulp 4" Vendor="WYZEN Products" Version="1.0"

ARG GULP_CLI_VERSION=4
ARG NPX_CLI_VERSION=10

ARG APPDIR=/app
ARG LOCALE=fr_FR.UTF-8
ARG LC_ALL=fr_FR.UTF-8
ENV LOCALE=fr_FR.UTF-8
ENV LC_ALL=fr_FR.UTF-8

RUN apt update && apt dist-upgrade -y \
    && apt-get -y --no-install-recommends install apt-transport-https ca-certificates gnupg-agent openssl software-properties-common curl wget git sudo cron locales \
    && npm update -g npm \
    && curl --compressed -o- -L https://yarnpkg.com/install.sh | bash \
    && sed -i "s/^# *\($LOCALE\)/\1/" /etc/locale.gen \
    && locale-gen $LOCALE && update-locale \
    && usermod -u 33 -d $APPDIR www-data && groupmod -g 33 www-data \
    && mkdir -p $APPDIR && chown www-data:www-data $APPDIR \
    && npm install -g --force npx@$NPX_CLI_VERSION \
    && yarn global add gulp-cli@$GULP_VERSION


COPY entrypoint.sh /

RUN mkdir -p /opt/ \
&& chmod +x /entrypoint.sh \
&& echo "alias ll='ls -hal'" >> /etc/bash.bashrc \
&& apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR $APPDIR
USER www-data:www-data

VOLUME ["/app", "/opt"]

#entrypoint ["/entrypoint.sh"]

