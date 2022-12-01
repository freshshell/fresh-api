FROM ruby:2.7.5

WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN gem install bundler:$(tail -n1 Gemfile.lock | awk '{print $1}') && bundle install

ENTRYPOINT []
CMD ["bash"]

ADD . ./
