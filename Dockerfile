# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

EXPOSE 8080

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0", "-p","8080"]
