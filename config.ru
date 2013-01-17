require 'bundler/setup'
Bundler.require(:default)

use Rack::Cache

require './site'
run Site.new