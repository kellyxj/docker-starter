FROM ubuntu:latest

WORKDIR /root
RUN apt update && \
	DEBIAN_FRONTEND=noninteractive apt install -y curl git && \
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
	chmod u+x nvim.appimage && \
	./nvim.appimage --appimage-extract && \
	mv squashfs-root / && \
	ln -s /squashfs-root/AppRun /usr/bin/nvim && \
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
	mkdir -p .config/nvim && \
	mkdir workdir
COPY init.vim  .config/nvim
RUN nvim +'PlugInstall --sync' +qa

ENTRYPOINT ["nvim", "workdir"]
