Encoding.default_external = 'UTF-8'
require 'bundler/setup'
Bundler.require(:default)

use Rack::Cache
use Rack::ETag
use Rack::Deflater

require 'tilt/template'
require 'kramdown'
require './categories'
require './site'
run Site.new
