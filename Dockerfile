FROM ubuntu:rolling

ARG TERM
ARG SHELL
ARG FOLDER
ARG USERNAME=z-shell
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --no-install-recommends -yq \
        ncurses-dev man telnet unzip zsh apt-transport-https jq gnupg2 git subversion curl make sudo locales \
        autoconf automake python3-minimal python3-pip libffi-dev python3-venv golang-go rsync socat build-essential \
        zlib1g tree vim nano less vim htop && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color
ENV SHELL=/bin/zsh

RUN echo 'playground' > /etc/hostname
RUN adduser --disabled-password --gecos '' $USERNAME    && \
    adduser $USERNAME sudo                              && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod --shell /bin/zsh $USERNAME
USER $USERNAME
COPY --chown=$USERNAME "$FOLDER" /home/${USERNAME}
RUN cp -vf /home/${USERNAME}/zshrc.zsh /home/${USERNAME}/.zshrc 2>/dev/null || true
WORKDIR /home/${USERNAME}
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)" -- -i skip
#RUN curl 'https://sh.rustup.rs' -sSf | sh -s -- -y  && \
#    echo 'source ${HOME}/.cargo/env' >> /home/$USERNAME/.zshenv
RUN if [ -f /home/${USERNAME}/bootstrap.sh ]; then \
  chmod u+x /home/${USERNAME}/bootstrap.sh; \
  /home/${USERNAME}/bootstrap.sh; \
fi

RUN SHELL=/bin/zsh zsh -i -c -- 'zi module build; @zi-scheduler burst || true '
CMD ["zsh", "-i", "-l"]
