FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /railsbb
WORKDIR /railsbb
COPY Gemfile /railsbb/Gemfile
COPY Gemfile.lock /railsbb/Gemfile.lock
RUN bundle install
COPY . /railsbb
