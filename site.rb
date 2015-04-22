require 'base64'
require 'time'

#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
    #require 'debugger' if development?
    #Debugger.start(:post_mortem => true) if development?


    helpers Hardwired::ContentFor

    #Load config.yml from the root
    config_file 'config.yml'



    helpers do
      def cache_for(time)
        response['Cache-Control'] = "public, max-age=#{time.to_i}"
      end

      def parse_domain(filename)
        w = filename
        parts = w.split(/\-/)

        tags = []
        while parts.last =~ /^[a-z]+$/ && parts.last != "v" do 
          tags << parts.pop
        end
        w = parts * "-"

        vert = parts.last == "v"
        parts.pop if vert

        ix = parts.pop; 
        tld = parts.last =~ /^(dk|com|ru|no|nl|org|pl|eu|se|ie|io|hr|it|uk|nz|au)$/ ? parts.pop : ""
        tld = "#{parts.pop}.#{tld}" if parts.last =~ /^(ac|co|com)$/; 

        domain = (parts * "-") + "." + tld

        Hardwired::RecursiveOpenStruct.new({domain: domain, vertical:vert, tags: tags, index: ix, url: "http://z.zr.io/rw/showcase/#{w}.png"})
      end 
    end

    before do
      redirect request.url.sub(/\/nathanaeljones\.com/, '/www.nathanaeljones.com'), 301 if request.host.start_with?("nathanaeljones.com")
    end



    get %r{\A/blog/(\d\d\d\d)\Z} do |year|
      request[:year] = year
      select_menu = '/blog'
      render_file('/blog')
    end
    get '/blog/tags/:tag' do |tag|
      request[:tag] = tag
      select_menu = '/blog'
      render_file('/blog')
    end

    get %r{/google([0-9a-z]+).html?} do |code|
      "google-site-verification: google#{code}.html" if config.google_verify.include?(code)
    end

    after '*' do 
      cache_for(dev? ? 30 : 60 * 60 * 24) #1 day
    end  

    Hardwired::Index.add_common_file('atom.xml.slim','atom.xml')
    add_alias('/rss.xml','atom.xml')
    add_alias('articles.xml','atom.xml')
    
    Hardwired::Index.add_common_file('sitemap.xml.slim','sitemap.xml')


    #debugger
    helpers do
      # Add new helpers here.
      def latest_release
        releases.first
      end
      def releases
        @@releases ||= Hardwired::Index.posts_tagged(:releases)
      end
      

       def editions
        Hardwired::Index.enum_files { |p| p.flag?(:edition)}.to_a.sort_by { |i| i.meta.sort_field || 0 }
      end


      def optimize_js(options, &block)
        Hardwired::JsOptimize.filter_includes(options,block.call)
      end 


      def store_hyperlinks_in(hash, varname, &block)
        require 'nokogiri'
        dom = Nokogiri::HTML::fragment(block.call)
        list = []
        dom.css('a').each do |a|
          list << a['href']
        end 
        hash[varname] = list.uniq.reject { |v| v.nil? || v.empty? }
        block.call
      end

      def nullify (&block)
        block.call
        ""
      end 

    end


    get '/alljs/jquery.min.map' do
      status 404
    end

    get '/openletter' do 
      redirect to ('http://www.nathanaeljones.com/openletter')
    end


    get '/alljs/:scripts' do |scripts|
      
      content_type "text/javascript"
      last_modified Time.new(request["m"])
      cache_for 60 * 60 * 24 * 30 #1 month
      Hardwired::JsOptimize.create_combined_response(Site, scripts, dev?)
    end 
end



module Hardwired
  class Template
    def hidden?
      flag?('hidden') or draft?
    end

    def bundle_name
      meta.bundle
    end
       
    def bundle
      Hardwired::Index["/plugins/bundles/#{meta.bundle}"]
    end

    def edition
      Hardwired::Index["/plugins/editions/#{meta.edition}"]
    end

    def edition_plugins
      @edition_plugins ||= Hardwired::Index.enum_files { |p| p.is_page? && p.can_render? && !meta.edition.nil? && !p.meta.edition.nil? && meta.edition.casecmp(p.meta.edition) == 0 && !p.flag?('edition')}.to_a.sort { |x, y| y.meta.sort_field <=> x.meta.sort_field }
    end


    def bundle_plugins
      @bundle_plugins ||= Hardwired::Index.enum_files { |p| p.is_page? && p.can_render? && p.bundle_name == bundle_name && !p.flag?('bundle')}.to_a
    end

  end
end

