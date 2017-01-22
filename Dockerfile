FROM convox/rails

COPY Gemfile      /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY Rakefile /app/Rakefile
COPY config   /app/config
COPY public   /app/public

COPY . /app
