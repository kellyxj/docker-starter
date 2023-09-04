FROM nestybox/ubuntu-jammy-systemd-docker
WORKDIR /root
RUN mkdir -p sources && mkdir -p /root/.ssh
RUN apt update && apt install -y openssh-server git docker-compose
COPY ed25519.pub /root/.ssh/authorized_keys
RUN service ssh start
EXPOSE 22 80 443
CMD ["/usr/sbin/sshd","-D"]
