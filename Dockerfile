FROM ubuntu:20.04

ARG USERNAME="z-shell"
ARG DEBIAN_FRONTEND=noninteractive
ARG TERM
ARG FOLDER

RUN apt-get update; \
apt-get -y install --no-install-recommends apt-transport-https curl wget jq git subversion telnet gnupg2 \
dirmngr iproute2 procps psmisc lsof htop locales zsh net-tools rsync socat ca-certificates unzip zip ncurses-dev \
file build-essential sudo lsb-release dialog zlib1g tree vim nano less manpages-dev python3-minimal python3-pip \
libffi-dev python3-venv man-db strace; \
apt-get clean -y; \
rm -rf /var/lib/apt/lists/*

ENV LC_ALL='C' LANG='en_US.UTF-8' LANGUAGE='en_US.UTF-8' \
  TERM="$TERM" SHELL='/bin/zsh'

RUN echo 'playground' > /etc/hostname; \
  adduser --disabled-password --gecos '' ${USERNAME}; \
  adduser ${USERNAME} sudo; \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
  usermod --shell /bin/zsh ${USERNAME}

USER ${USERNAME}
COPY --chown=${USERNAME} "$FOLDER" /home/${USERNAME}

RUN cp -vf /home/${USERNAME}/zshrc.zsh /home/${USERNAME}/.zshrc 2>/dev/null || true; \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)" -- -i skip

RUN if [ -f /home/${USERNAME}/bootstrap.sh ]; then \
  chmod u+x /home/${USERNAME}/bootstrap.sh; \
  /home/${USERNAME}/bootstrap.sh; \
fi

WORKDIR /home/${USERNAME}
RUN zsh -i -ls -c -- '@zi-scheduler burst || true'
CMD ["/bin/zsh", "-l"]
