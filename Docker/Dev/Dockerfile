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

RUN gem install bundler
RUN npm install

RUN mkdir /var/www/
WORKDIR /var/www/

COPY ../../Gemfile ../../Gemfile.lock ./

RUN bundle install

EXPOSE 3000

# CMD ["bundle exec", "rails", "server", "-b 0.0.0.0"]

# Sample command to run the image
# First, create the image:

# docker build -t puzzle-plan .
# docker build -t puzzle-plan -f Docker/Dev/Dockerfile .

# Now, run setting up the local code folder 
# docker run -it --name puzzle-plan -v <LOCAL_CODE_FOLDER_HERE>:/var/www -p 3000:3000 puzzle-plan bash

# If fails do bundle install, remove the Gemfile.lock and doit again. Else, run "gem update --system -N" (wait a long time)

# needs to execute this way to work 
# bundle exec rails s -b 0.0.0.0 

CMD tail -f /dev/null