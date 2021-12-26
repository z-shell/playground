FROM ubuntu:impish
ARG USERNAME=user

# Update && install common dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y jq git man subversion curl telnet rsync \
  libuser ncurses-dev file zsh make tree locales apt-utils sudo autoconf automake python3-dev \
  vim htop unzip \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG TERM
ENV TERM $TERM 
ENV SHELL=/bin/zsh 
ENV LANG en_US.UTF-8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# Add user
RUN adduser --disabled-password --gecos '' ${USERNAME} && adduser ${USERNAME} sudo && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod --shell /bin/zsh ${USERNAME}
USER ${USERNAME}

# Install
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)"

# Copy configs into home directory
ARG FOLDER
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
