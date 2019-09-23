FROM ruby:2.4.0
  
COPY . /resizer-web
WORKDIR /resizer-web

RUN     curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
        apt-get install -y nodejs && \
        bundle install

ENV PORT=3000
EXPOSE 3000

CMD ["bundle", "exec" , "puma" , "-C", "puma.rb"]
