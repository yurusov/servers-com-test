FROM ruby:3.2.0-alpine as builder

RUN set -ex \
  && apk add --no-cache \
     build-base \
     postgresql-dev
COPY Gemfile* ./
RUN bundle install

FROM ruby:3.2.0-alpine as runner

WORKDIR /app
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .
EXPOSE 2300
CMD ["bundle", "exec", "hanami", "server", "--host", "0.0.0.0"]
