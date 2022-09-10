ARG ELIXIR_VERSION=1.14.0
ARG APP_DIR=/opt/app
ARG MIX_ENV=prod
ARG OTP_APP=elixir_dev

# FROM us-docker.pkg.dev/$PROJECT_ID/$PATH/elixir:${ELIXIR_VERSION}-alpine AS builder
FROM elixir:${ELIXIR_VERSION}-alpine AS builder
ARG APP_DIR
ARG MIX_ENV
ARG ELIXIR_VERSION
ENV ELIXIR_VERSION $ELIXIR_VERSION
ENV MIX_ENV $MIX_ENV
ENV MIX_HOME $APP_DIR/.mix
ENV HEX_HOME $APP_DIR/.hex
ENV REBAR_CACHE_DIR $APP_DIR/.cache
COPY . $APP_DIR
RUN apk add --no-cache bash make gcc libc-dev
WORKDIR $APP_DIR
RUN mix do local.hex --force --if-missing, \
    local.rebar --force --if-missing, \
    deps.get --only $MIX_ENV, \
    release --overwrite
RUN mkdir -p deps .cache .hex
RUN if [ "$MIX_ENV" == "test" ]; then mix dialyzer --plt; fi

# FROM us-docker.pkg.dev/$PROJECT_ID/$PATH/elixir:${ELIXIR_VERSION}-alpine
FROM elixir:${ELIXIR_VERSION}-alpine
ARG APP_DIR
ARG OTP_APP
ARG MIX_ENV
ARG BUILD_DIR=$APP_DIR/_build
ENV MIX_ENV $MIX_ENV
WORKDIR $BUILD_DIR
COPY --from=builder $BUILD_DIR .
ARG RUN_DIR=$BUILD_DIR/$MIX_ENV/rel/$OTP_APP/bin
WORKDIR $RUN_DIR
CMD ["./elixir_dev","start"]
