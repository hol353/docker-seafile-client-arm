FROM debian:bullseye-slim

RUN apt-get update && apt-get install gnupg curl -y && \
    echo deb http://deb.debian.org/debian bullseye-backports main >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y seafile-cli procps grep && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR /seafile-client

COPY start.sh /seafile-client/start.sh

RUN chmod +x /seafile-client/start.sh && \
    useradd -U -d /seafile-client -s /bin/bash seafile && \
    usermod -G users seafile && \
    chown seafile:seafile -R /seafile-client && \
    su - seafile -c "seaf-cli init -d /seafile-client"

CMD ["./start.sh"]
