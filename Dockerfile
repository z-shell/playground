FROM ubuntu:impish-20211102

# Update && install common dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
  apt install -yq \
  ncurses-dev man telnet unzip zsh git subversion curl make sudo locales \
  autoconf automake python golang-go \
  vim htop

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add user
RUN adduser --disabled-password --gecos '' user         && \
  adduser user sudo                                   && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  usermod --shell /bin/zsh user
USER user

# Install
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ss-o/zi-src/main/lib/sh/install.sh)"

# Copy configs into home directory
ARG FOLDER
COPY --chown=user "${FOLDER}" /home/user
# Copy of a possible .zshrc named according to a non-leading-dot scheme
RUN cp -vf /home/user/zshrc.zsh /home/user/.zshrc 2>/dev/null || true

# Install Rust language
RUN curl 'https://sh.rustup.rs' -sSf | sh -s -- -y  && \
  echo 'source ${HOME}/.cargo/env' >> /home/user/.zshenv

# Run user's bootstrap script
RUN if [ -f /home/user/bootstrap.sh ]; then \
  chmod u+x /home/user/bootstrap.sh; \
  /home/user/bootstrap.sh; \
  fi

# Install all plugins
ARG TERM
ENV TERM ${TERM}
RUN SHELL=/bin/zsh zsh -i -c -- 'zi module build; @zi-scheduler burst || true '

CMD zsh -i -l
