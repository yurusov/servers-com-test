FROM ruby:3.2.2-alpine as builder

RUN set -ex \
  && apk add --no-cache \
     build-base \
     postgresql-dev
COPY Gemfile* ./
RUN bundle install

FROM ruby:3.2.2-alpine as runner

WORKDIR /app
RUN apk add --no-cache \ 
    postgresql-dev \
    postgresql-client \
    dumb-init
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .
EXPOSE 2300
ENTRYPOINT ["/usr/bin/dumb-init", "-c", "--"]

CMD ["/bin/sh", "-c", "/app/docker/start_app.sh"]

