
FROM dockurr/windows:latest

RUN set -eu && \
    apt-get update && \
    apt-get --no-install-recommends -y install \
    netcat-openbsd \
    git \
    sudo \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/run/sshd


ARG SSHPORT=2222

COPY ./scripts/* /oem/ 

RUN echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "PermitTunnel yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "ForceCommand /usr/bin/ssh -q $USERNAME@localhost -p $SSHPORT" >> /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 8006 3389 22  

RUN useradd -m -s /bin/bash daytona && \
    echo "daytona:daytona" | chpasswd && \
    usermod -aG sudo daytona && \
    echo "daytona ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


ENTRYPOINT [ "/bin/bash" ]