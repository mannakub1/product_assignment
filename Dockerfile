FROM ruby:2.7.1-alpine3.12
ENV RAILS_ENV="development"
WORKDIR /app

RUN apk add --no-cache --update \
  build-base \
  tzdata \
  postgresql-client \
  postgresql-dev \
  bash

# cache bundle install
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler -v 2.1.4;
RUN bundle install

ARG APP_HOME="/app"
COPY . ${APP_HOME}
EXPOSE $PORT