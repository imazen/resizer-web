require 'bundler/setup'
Bundler.require(:default)

use Rack::Cache
use Rack::ETag

require 'hardwired/rack_deflater'
use Hardwired::Deflater

if defined?(Honeybadger)
  # Configure the API key
  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
  end
   
  # And use Honeybadger's rack middleware
  use Honeybadger::Rack
end

require './site'
run Site.new