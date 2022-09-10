# FROM us-docker.pkg.dev/$PROJECT_ID/$PATH/elixir:1.13.4-alpine
ARG ELIXIR_VERSION=1.14.0
FROM elixir:${ELIXIR_VERSION}-alpine

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=elixir-dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apk add --no-cache bash make gcc libc-dev git sudo \
    && addgroup -g $USER_GID $USERNAME \
    && adduser -s /bin/bash -u $USER_UID -G $USERNAME -h /home/$USERNAME -D $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV HOME /home/$USERNAME
# WORKSPACE is /workspaces/$USERNAME when not using docker-compose
# ENV WORKSPACE /workspaces/$USERNAME
ENV WORKSPACE /workspace
ENV MIX_HOME $WORKSPACE/.mix
ENV HEX_HOME $WORKSPACE/.hex
ENV REBAR_CACHE_DIR $WORKSPACE/.cache
