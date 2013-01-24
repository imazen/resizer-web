require 'bundler/setup'
Bundler.require(:default)

use Rack::Cache

# Configure the API key
Honeybadger.configure do |config|
  config.api_key = ENV['HONEYBADGER_API_KEY']
end
 
# And use Honeybadger's rack middleware
use Honeybadger::Rack

require './site'
run Site.new