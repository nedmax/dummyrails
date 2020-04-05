FROM ruby:2.7.1
RUN apt-get update -qq \
  && apt-get install -y build-essential postgresql-client nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
