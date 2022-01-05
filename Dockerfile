FROM ubuntu:latest

ARG USERNAME=user
ARG DEBIAN_FRONTEND=noninteractive
ARG TERM
ARG FOLDER

RUN apt-get update && apt-get install -yq \
apt-transport-https curl wget jq git subversion telnet gnupg2 dirmngr iproute2 procps psmisc lsof htop locales zsh ncdu net-tools rsync \
ca-certificates unzip zip ncurses-dev file make automake autoconf sudo lsb-release dialog zlib1g tree vim nano less manpages manpages-dev \
python3-dev python3-pip python-is-python3 man-db strace 

ENV TERM $TERM 
ENV SHELL=/bin/zsh 
ENV LANG en_US.UTF-8
RUN echo 'playground' > /etc/hostname
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

RUN adduser --disabled-password --gecos '' ${USERNAME} && adduser ${USERNAME} sudo && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod --shell /bin/zsh ${USERNAME}
USER ${USERNAME}

COPY --chown=${USERNAME} "$FOLDER" /home/${USERNAME}

RUN cp -vf /home/${USERNAME}/zshrc.zsh /home/${USERNAME}/.zshrc 2>/dev/null || true
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)" -- -i skip
RUN if [ -f /home/${USERNAME}/bootstrap.sh ]; then \
  chmod u+x /home/${USERNAME}/bootstrap.sh; \
  /home/${USERNAME}/bootstrap.sh; \
  fi

WORKDIR /home/${USERNAME}

RUN zsh -i -ls -c -- '@zi-scheduler burst || true'

CMD ["/bin/zsh"]
