FROM ruby:3.0-buster

RUN apt-get update -q
RUN apt-get install -y curl git vim \
                        g++ make gcc \
                        postgresql-contrib libpq-dev \
                        nodejs npm

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 12.16.1
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /var/www/

EXPOSE 3000

# COPY ../../ /var/www/

RUN npm install
RUN bundle install
RUN bundle exec rake assets:precompile

# CMD ["bundle exec", "rails", "server"]