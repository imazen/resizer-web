require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*.rb"
end

task :inventory do
  require 'bundler/setup'
  Bundler.require(:default)
  require './categories'
  require './support_contracts'
  require './site'
  s = Site.new

  all_urls = Hardwired::Index.pages.map{|p| [p.path, p.aliases]}.flatten.flatten.uniq.sort
  File.open("inventory.txt", 'w') do |file| 
    all_urls.each do |url| 
      file.write("#{url}\n")
    end
  end
end


task :default => ['test']