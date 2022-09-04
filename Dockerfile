FROM ruby:2.7.5

WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN bundle install

ENTRYPOINT []
CMD ["bash"]

ADD . ./
