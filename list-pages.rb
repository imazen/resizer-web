#!/usr/bin/env ruby
# List all renderable, non-hidden pages (one path per line)
ENV['RACK_ENV'] = 'test'
$VERBOSE = false
require 'bundler/setup'
Bundler.require(:default)
require 'tilt/template'
require 'kramdown'
require_relative 'categories'
require_relative 'site'

Hardwired::Index.pages
  .reject { |p| p.flag?(:hidden) || p.path.end_with?('sitemap.xml') || p.path.end_with?('atom.xml') }
  .map(&:path).sort
  .each { |p| puts p }
