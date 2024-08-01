#!/usr/bin/env ruby
# coding: utf-8
PORT=4605
STDOUT << "Running on port #{PORT}\n"
`bundle exec rerun --dir '.' --pattern '**/*.{rb,slim,js,yml,css,less, scss,sass,erb,html,htmf,haml,ru,haml,md,mdown,markdown}' -- bundle exec puma -C puma.rb --debug --port=#{PORT}`
