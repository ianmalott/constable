FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl git inotify-tools phantomjs rebar wget

# Add Erlang Solutions repo
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb

# Install the Erlang/OTP platform, all of its applications, and Elixir
RUN apt-get update && apt-get install -y esl-erlang elixir

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

WORKDIR app

# Install Elixir dependencies and compile
COPY mix.exs /app/mix.exs
COPY mix.lock /app/mix.lock
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

# Install npm dependencies
COPY package.json /app/package.json
RUN npm install

COPY . .

CMD ["mix",  "phoenix.server"]
