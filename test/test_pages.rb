
ENV['RACK_ENV'] = 'test'
$VERBOSE = false
require 'bundler/setup'
require 'rack/test'
require 'test/unit'
Bundler.require(:default)
Bundler.require(:development)
require_relative '../categories'
require_relative '../support_contracts'
require_relative '../site'


Webrat.configure do |config|
  config.mode = :rack
end

class TestAllPages < Test::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Site.new
  end

  def test_home_page
    visit '/'
    assert_contain('ImageResizer')
  end

  puts "Building #{Hardwired::Index.pages.length} test methods"
  Hardwired::Index.pages.each do |page|
    define_method(("test_" + page.path).to_sym) do 
      visit page.path
      
      assert_contain "ImageResizer" 
    end unless (page.flag?(:hidden) || page.path.end_with?("sitemap.xml"))
  end 

end
