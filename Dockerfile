FROM ruby:2.7.1-alpine as builder

ENV RAILS_ENV production
ENV RACK_ENV production

RUN apk add --no-cache --update build-base \
                                postgresql-dev \
                                && rm -rf /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install && rm -rf /usr/local/bundle/bundler/gems/*/.git \
                             /usr/local/bundle/cache/

FROM ruby:2.7.1-alpine

RUN apk add --no-cache --update postgresql-dev \
                                tzdata \
                                && rm -rf /var/cache/apk/*

RUN addgroup -S deploy && adduser -S deploy -G deploy
USER deploy
RUN mkdir -p /home/deploy/app
WORKDIR /home/deploy/app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --chown=deploy:deploy . /home/deploy/app/

EXPOSE 3000
CMD ["bin/run-dev.sh"]
