require 'base64'
require 'time'

#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
    require 'debugger' if development?
    #Debugger.start(:post_mortem => true) if development?


    helpers Hardwired::ContentFor

    #Load config.yml from the root
    config_file 'config.yml'



    helpers do
      def cache_for(time)
        response['Cache-Control'] = "public, max-age=#{time.to_i}"
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
      
      def bundles
        Hardwired::Index.enum_files { |p| p.flag?(:bundle)}
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


    get '/alljs/:scripts' do |scripts|
      scripts = scripts.split(',').map{|s| Base64.urlsafe_decode64(s)}

 

      compressor = defined?(YUI) && defined?(YUI::JavaScriptCompressor) && YUI::JavaScriptCompressor.new(:munge => false)

      session = Rack::Test::Session.new(Site)
      combined = scripts.map { |path|
        content = nil
        result = session.get(path)
        if result.body.respond_to?(:force_encoding)
          response_encoding = result.content_type.split(/;\s*charset\s*=\s*/).last.upcase rescue 'ASCII-8BIT'
          content = result.body.force_encoding(response_encoding).encode(Encoding.default_external || 'ASCII-8BIT')  if result.status == 200
        else
          content = result.body  if result.status == 200
        end
        path.end_with?("min.js") || dev? ? content : compressor ? compressor.compress(content) : content

      }.join("\n")

      content_type "text/javascript"
      last_modified Time.new(request["m"])
      cache_for 60 * 60 * 24 * 30 #1 month
      combined
    end 
end

module Hardwired
  class JsOptimize
    @@include_cache = {}
    def self.filter_includes(options = {:defer => true}, fragment)

      return @@include_cache[fragment] if @@include_cache[fragment]
      require 'nokogiri'
      dom = Nokogiri::HTML::fragment(fragment)
      scripts = []
      mod_dates = []
      dom.css('script').each do |i|
        url = i["src"]
        next if url.start_with?("http") || url.start_with?("//")
        try_urls = [url.sub(/(?<!min)\.js\Z/i,".min.js"),url.sub(/(?<!min)\.js\Z/i,"-min.js"), url]
        mod_date = nil 
        try_urls.each do |u|
          begin 
            mod_date = File.mtime(Hardwired::Paths.content_path(u))
            url = u
            p url
            p mod_date
            break
          rescue
            next
          end
        end
        next if mod_date == nil 

        mod_dates << mod_date
        scripts << url
        i.remove
      end 

      avg_mod_date = mod_dates.map{|d| d.to_f}.reduce(:+).to_f / mod_dates.size

      sNode = Nokogiri::XML::Node.new('script',dom)
      sNode['defer'] = "defer" if options[:defer]
      sNode['async'] = "true" if options[:async]
      sNode['src'] = "/alljs/" + scripts.map{|s| Base64.urlsafe_encode64(s)}.join(',') + "?m=" + Time.at(avg_mod_date).to_s


      result = sNode.to_html + dom.to_html

      @@include_cache[fragment] = result
      result


    end 


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

