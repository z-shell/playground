FROM ubuntu:impish
ARG USERNAME=user DEBIAN_FRONTEND=noninteractive TERM FOLDER

RUN apt-get update \
&& apt-get install -yq apt-utils jq git subversion telnet gnupg2 dirmngr iproute2 procps lsof htop \
net-tools psmisc curl wget rsync ca-certificates unzip zip nano ncurses-dev file zsh make \
vim-tiny less jq lsb-release apt-transport-https dialog zlib1g tree autoconf automake sudo \
python3-dev python3-pip python-is-python3 locales ncdu man-db strace manpages manpages-dev \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TERM $TERM 
ENV SHELL=/bin/zsh 
ENV LANG en_US.UTF-8
RUN echo 'playground' > /etc/hostname
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# Add user
RUN adduser --disabled-password --gecos '' ${USERNAME} && adduser ${USERNAME} sudo && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod --shell /bin/zsh ${USERNAME}
USER ${USERNAME}

# Install ZI
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)"

# Copy configs into home directory
COPY --chown=${USERNAME} "$FOLDER" /home/${USERNAME}

# Copy of a possible .zshrc named according to a non-leading-dot scheme
RUN cp -vf /home/${USERNAME}/zshrc.zsh /home/${USERNAME}/.zshrc 2>/dev/null || true

# Run user's bootstrap script
RUN if [ -f /home/${USERNAME}/bootstrap.sh ]; then \
  chmod u+x /home/${USERNAME}/bootstrap.sh; \
  /home/${USERNAME}/bootstrap.sh; \
  fi

WORKDIR /home/${USERNAME}

# Install all plugins
RUN zsh -ils -c -- '@zi-scheduler burst || true'

CMD ["/bin/zsh"]
