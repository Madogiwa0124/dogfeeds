FROM ruby:2.7.2-alpine
ENV TZ=Asia/Tokyo
ENV BUNDLE_PATH /usr/local/bundle

ARG APP_NAME
RUN apk add --no-cache --update \
    bash \
    build-base \
    postgresql-dev \
    postgresql \
    nodejs \
    yarn \
    tzdata \
    less \
    curl \
    chromium \
    chromium-chromedriver \
    libc6-compat

RUN mkdir /${APP_NAME}
WORKDIR /${APP_NAME}

# NOTE: https://qiita.com/hiko1129/items/5f1914d01b7ee3713b62
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2
