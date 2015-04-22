require 'bundler/setup'
Bundler.require(:default)

if defined?(Rack::PerftoolsProfiler)
  require 'rack/perftools_profiler'
  use ::Rack::PerftoolsProfiler, :default_printer => 'gif'
end 

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

require 'tilt/template'
require 'kramdown'
require './categories'
require './support_contracts'
require './site'
run Site.new