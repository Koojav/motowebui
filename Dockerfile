FROM ruby:2.3

RUN apt-get update && apt-get install -y --no-install-recommends nodejs mysql-client && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY . .
RUN bundle install
CMD chmod +x /usr/src/app/entrypoint.sh

EXPOSE 3000
ENTRYPOINT /usr/src/app/entrypoint.sh