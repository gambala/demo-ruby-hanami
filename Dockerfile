# Use the official Ruby image as a parent image
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-alpine AS base

# Set the working directory in the container
WORKDIR /app

# Install base packages
RUN apk add --no-cache jemalloc gcompat

# Install tzinfo-data: assets:precompile and rails in boot time need it
RUN apk add --no-cache tzdata

# Set production environment
ENV HANAMI_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test:cli"



# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apk add --no-cache build-base git

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the necessary gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy the rest of the application code into the container
COPY . .



# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /app /app

# Deployment options
ENV LD_PRELOAD="libjemalloc.so.2" \
    MALLOC_CONF="dirty_decay_ms:1000,narenas:2,background_thread:true" \
    RUBY_YJIT_ENABLE="1"

# Expose the port that the app runs on
EXPOSE 2300

# Define the command to run the application
CMD ["bundle", "exec", "hanami", "server"]
