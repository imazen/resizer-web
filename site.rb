
#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
    require 'debugger' if development?
    #Debugger.start(:post_mortem => true) if development?

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
    end
end

module Hardwired
  class Template
    def hidden?
      flag?('hidden') or draft?
    end

    def default_layout
      Paths.layout_subfolder +  (meta.bundle ? '/plugin_page' : '/page')
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

