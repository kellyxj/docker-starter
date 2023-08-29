FROM ubuntu:latest
RUN apt update && apt install -y openssh-server
RUN mkdir -p /root/.ssh
COPY ed25519.pub /root/.ssh/authorized_keys
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
