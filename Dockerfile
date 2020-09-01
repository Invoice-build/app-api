FROM ruby:2.7.1-alpine

ENV RAILS_ENV production
ENV RACK_ENV production

RUN apk add --no-cache --update postgresql-dev \
                                tzdata \
                                && rm -rf /var/cache/apk/*

# We specify everything will happen within the /app folder inside the container
WORKDIR /app
# We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock ./
# We install all the dependencies
RUN bundle install
# We copy all the files from our current application to the /app container
COPY . .

RUN mkdir -p ./tmp/storage && mkdir -p ./tmp/pids && touch ./tmp/pids/server.pid

# Execute the Procfile
CMD ["bin/run-dev.sh"]
