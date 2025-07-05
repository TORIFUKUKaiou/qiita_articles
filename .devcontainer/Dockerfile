# Update the VARIANT arg in docker-compose.yml to pick a Ubuntu version
ARG VARIANT="ubuntu-24.04"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

# This Dockerfile adds a non-root user with sudo access. Update the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=vscode

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt-get update && apt-get install -y xz-utils build-essential inotify-tools git curl unzip sed ca-certificates gnupg

RUN su ${USERNAME} -c "mkdir -p /home/${USERNAME}/.elixir-install"
RUN su ${USERNAME} -c "curl -fsSo '/home/${USERNAME}/.elixir-install/install.sh' 'https://elixir-lang.org/install.sh'"

ARG ELIXIR_VERSION='1.18.4'
ARG ELIXIR_OTP_RELEASE='28'
ARG OTP_VERSION='28.0.1'

RUN su ${USERNAME} -c "sh /home/${USERNAME}/.elixir-install/install.sh elixir@${ELIXIR_VERSION} otp@${OTP_VERSION}"
RUN su ${USERNAME} -c "echo 'export PATH=/home/${USERNAME}/.elixir-install/installs/otp/${OTP_VERSION}/bin:/home/${USERNAME}/.elixir-install/installs/elixir/${ELIXIR_VERSION}-otp-${ELIXIR_OTP_RELEASE}/bin:$PATH' >> /home/${USERNAME}/.profile"

RUN su ${USERNAME} -c "source /home/${USERNAME}/.profile \
  && mix local.hex --force \
  && mix local.rebar --force

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*
