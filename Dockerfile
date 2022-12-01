FROM ruby:2.7.7

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:$(tail -n1 Gemfile.lock | awk '{print $1}') && bundle install

ENTRYPOINT []
CMD ["bash"]

COPY . ./
