FROM ruby:2.7.5-slim as builder

ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get -y upgrade && \
    apt-get install --no-install-recommends -y git gcc build-essential libreadline-dev zlib1g-dev libmariadb-dev-compat libmariadb-dev libxml2-dev libxslt1-dev pkg-config

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY vendor/ /app/vendor
RUN bundle install -j4

FROM ruby:2.7.5-slim

ENV LANG C.UTF-8

RUN apt-get update && apt-get -y upgrade && \
    apt-get install --no-install-recommends -y tzdata default-libmysqlclient-dev zlib1g libxml2 libxslt1.1 nodejs mariadb-client \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN mkdir /app
WORKDIR /app
RUN useradd test -d /app -M -U
COPY . /app

RUN chown -R test:test /app && \ 
    chmod 0666 -R /app/log /app/tmp
USER test

CMD ["bundle", "exec", "rails", "s"]
