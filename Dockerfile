FROM ruby:2.7.1-alpine3.12

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
RUN bundle install --deployment 

