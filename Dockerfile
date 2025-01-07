
FROM dockurr/windows:latest

RUN set -eu && \
    apt-get update && \
    apt-get --no-install-recommends -y install \
    netcat-openbsd \
    sudo \
    git \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/run/sshd

COPY ./scripts/* /oem/ 

ENV SSHPORT=10022
ENV USERNAME=daytona
ENV PASSWORD=daytona

RUN echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "PermitTunnel yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "ForceCommand /usr/bin/ssh -q $USERNAME@localhost -p $SSHPORT" >> /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 8006 3389 22  


ENTRYPOINT ["sleep", "infinity" ]