FROM ubuntu:latest
WORKDIR sources
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \ 
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
	--mount=src=key,target=/root/key \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt update && apt install -y openssh-server git \
	&& mkdir -p /root/.ssh \
	&&  cp /root/key/ed25519.pub /root/.ssh/authorized_keys
RUN service ssh start 
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
