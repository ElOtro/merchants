# Dockerfile development version
FROM ruby:3.2.1 AS merchants-development

# Install
RUN apt-get update && apt-get install -y --no-install-recommends

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY merchants-api/ .
RUN gem install rails bundler
RUN bundle check || bundle install --jobs 4

# Start server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]