require 'base64'
require 'time'
require 'money'
#Set the root directory
Hardwired::Paths.root = ::File.expand_path('.', ::File.dirname(__FILE__))
I18n.config.available_locales = :en

DEFAULT_DOCS_VERSION = "v4"

##The location of the current file is used for calculating the default 'root' setting
class Site < Hardwired::Bootstrap
    #require 'debugger' if development?
    #Debugger.start(:post_mortem => true) if development?


    helpers Hardwired::ContentFor

    #Load config.yml from the root
    config_file 'config.yml'



    helpers do
      def canonical
        pn = request[:page]
        uri = URI::join(config.url,page.path)
        if pn
          uri.query = URI.encode_www_form({"page" => pn})
        end
        uri
      end

      def versions
        [{id: "v2", 
          folder: "/docs/v2/", 
          home: "/docs/v2",
          title: "v2.X"},
          {id: "v3", 
            folder: "/docs/v3/", 
            home: "/docs/v3", 
            title: "v3.x"},
          {id: "v4", 
            folder: "/docs/v4/", 
            home: "/docs/v4", 
            title: "v4.x"}]

      end 

      def nav_generate_plugins(version, arg_1)
        
        index.pages_tagged("plugin").sort_by{|page| page.heading}.select{|page| page.path.start_with?("/docs/#{version}/")}.map do |page|
          {"path" =>  page.path, "title" => page.heading}
        end
      end 
      def nav_generate_releases(version, arg_1)
        releases.map{|page| {"path" =>  page.path, "title" => page.heading}}
      end 
      def nav_resolve(yaml_tree, relative_to, version_id)
        #Process generated content
        gen_name = yaml_tree["generate"]
        gen_arg_1 = yaml_tree["generate_arg_1"]
        if (gen_name == "plugins")
          yaml_tree["items"] = nav_generate_plugins(version_id, gen_arg_1)
        end 
        if (gen_name == "releases")
          yaml_tree["items"] = nav_generate_releases(version_id, gen_arg_1)
        end 

        #resolve relative URLs
        path = yaml_tree["path"]
        unless path.nil?
          path = File.join(relative_to,path) unless path.start_with?('/')
          yaml_tree["path"] = path
        end

        #recurse
        yaml_tree["items"].each do |child|
          nav_resolve(child, relative_to, version_id)
        end unless yaml_tree["items"].nil?
        yaml_tree
      end 
      def nav_docs_tree(version)
        yml = YAML.load(File.read(Hardwired::Paths.content_path("docs/#{version}/nav.yml")))
        nav_resolve(yml, "/docs/#{version}/", version)
      end 


      def default_version
        DEFAULT_DOCS_VERSION
      end

      def active_version
        m = /\A\/docs\/(v[0-9\.]+|latest)/.match(request.path)
        return m[1] unless m.nil?

        default_version
      end



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

        Hardwired::RecursiveOpenStruct.new({quote: nil, domain: domain, vertical:vert, tags: tags, index: ix, url: "https://z.zr.io/rw/showcase/#{w}.png"})
      end 

      def generate_products(discount, coupon)
        Hash[{
          elite_basic: {
            yearly: {id: "enterprise-wide-elite-edition-yearly", 
                     price: 7200, 
                     addons: ["basic-email-support"]}, 
             monthly: {id: "enterprise-wide-elite-edition-monthly", 
                     price: 700, 
                     addons: ["basic-email-support"]},         

          },
          elite_basic_perpetual: {
            yearly: {id: "enterprise-wide-elite-edition-yearly", 
                     price: 7200, 
                     first: {
                        price: 10800
                     }, 
                     addons: ["basic-email-support","enterprise-wide-elite-perpetual-upgrade"]}, 
     

          },
          elite: {
            yearly: {id: "enterprise-wide-elite-edition-yearly", 
                     price: 3600, 
                     addons: []}, 
             monthly: {id: "enterprise-wide-elite-edition-monthly", 
                     price: 400, 
                     trial: 30},         

          },
          elite_perpetual: {
            yearly: {id: "enterprise-wide-elite-edition-yearly", 
                     price: 3600, 
                     first: {
                        price: 7200
                     }, 
                     addons: ["enterprise-wide-elite-perpetual-upgrade"]}, 
     

          },
          performance: {
              yearly: {id: "enterprise-wide-performance-edition-yearly", 
                     price: 2400, 
                     addons: []}, 
             monthly: {id: "enterprise-wide-performance-edition-monthly", 
                     price: 260, 
                     trial: 30},         

          },
          performance_perpetual: {
              yearly: {id: "enterprise-wide-performance-edition-yearly", 
                     price: 2400, 
                     first: {
                        price: 4800
                     }, 
                     addons: ["enterprise-wide-performance-perpetual-upgrade"]}, 
                    
          },
          project_performance: {
              yearly: {id: "project-performance-yearly", 
                     price: 1800}      

          },
          project_performance_perpetual: {
              yearly: {id: "project-performance-yearly", 
                     price: 1800,
                     first: {
                        price: 3600
                     }, 
                     addons: ["project-performance-perpetual-upgrade"]}      

          },
          addon_server_performance: {
             monthly: {nodiscount_price: 70},         
          },
          addon_server_elite: {
             monthly: {nodiscount_price: 100},         
          },
          addon_247: {
             monthly: {nodiscount_price: 599},         
          },
          addon_basic: {
             monthly: {price: 300},         
          },
          addon_oem: {
             monthly: {price: 400},         
          },
          addon_imageflow: {
             monthly: {price: 140},         
          },
          addon_performance_perpetual: {
             once: {price: 2400},         
          },
          addon_elite_perpetual: {
             once: {price: 3600},         
          }
        }.map{ |k, d|  

          # Add price and signup link
          d = Hash[d.map{ |k, v|  
              query =  {}
              query["subscription[coupon]"] = coupon if coupon
              if v[:addons]
                v[:addons].each_with_index do |e, ix|
                   query["addons[id][#{ix}]"] = e
                end
              end 

              def get_price(h, discount)
                Money.new((h[:nodiscount_price] || (h[:price] - (h[:price] * discount))) * 100, "USD")
              end 

              adjustments = {
                price: get_price(v, discount),
                first_price: v[:first] ? get_price(v[:first], discount) : nil
              }
              adjustments[:link] = "https://account.imazen.io/hosted_pages/plans/#{v[:id]}?#{URI.encode_www_form(query)}" if v[:id]
              [k, v.merge(adjustments)]
          }]

          # Calculate yearly discount
          d = Hash[d.map{ |k, v| 
              price = v[:price] 
              first_price = v[:first_price] 
              trial_prefix = v[:trial] ? "Free #{v[:trial]} day trial &#8226; " : ""

              text = ""
              price_summary = ""

              raise "not implemented" if first_price && k != :yearly 

              if k == :monthly then 
                text = v[:trial] ? 
                  "#{trial_prefix} #{price.format}/month" :
                  "Start now &#8226; #{price.format}/month"

                price_summary = "#{price.format}/month"
              elsif k == :yearly
                if first_price then 
                  price_summary = text = "#{trial_prefix} Pay #{first_price.format} 1st year, then #{price.format} yearly"
                else
                  if d[:monthly] && d[:yearly] then 
                    yearly_saves = d[:monthly][:price] * 12 - d[:yearly][:price]
                    text = "#{trial_prefix} Pay #{d[:yearly][:price].format} yearly &#8226; Save #{yearly_saves.format} yearly" 
                  else
                    text = "#{trial_prefix} Sign up yearly billing"
                  end 

                  price_summary = "#{(price / 12).format}/month billed yearly" 
                end 
              elsif k == :once
                text = "#{trial_prefix} #{price.format}"
                price_summary = "#{price.format}"
              else 
                raise "not supported"
              end 

              [k, v.merge({
                price_summary: price_summary.strip,
                button: text.strip
              })]
          }]

          d[:price_summary] = (d[:yearly] || d[:monthly] || d[:once])[:price_summary]
          [k, d]
        }] 
      end 

      def generate_org_sizes
        Hash[{
            "large" => {
            name: "Large Business",
            restricted: "with 500 or more employees.",
            icon: "icon-globe",
            summary: "Large business - more than 500 employees.",
            discount: 0
          },
          "medium" => {
            name: "Medium Business",
            restricted: "with fewer than 500 employees.",
            icon: "icon-building",
            summary: "Medium business - fewer than 500 employees.",
            discount: 0.5, 
            coupon: "SMB_ONLY"
          },
          "small" => {
            name: "Small Business",
            restricted: "with fewer than 30 employees.",
            icon: "icon-group",
            summary: "Small business - fewer than 30 employees.",
            discount: 0.6, 
            coupon: "SMALLBIZ_ONLY"
          },
          "micro" => {
            name: "Microenterprise",
            restricted: "with fewer than 5 employees and gross revenue below $250,000/quarter USD.",
            icon: "icon-user",
            summary: "Microenterprise - fewer than 5 employees. Gross revenue below $250,000/quarter USD.",
            discount: 0.8, 
            coupon: "MICRO_ENTERPRISE_ONLY"
          },
          
          "nonprofit" => {
            name: "Non-profit",
            restricted: "with non-profit and tax-exempt status.",
            icon: "icon-medkit",
            summary: "Charitable organizations - with non-profit and tax-exempt status.",
            discount: 0.6, 
            coupon: "NONPROFIT_ONLY"
          }
        }.map{|k,v| 
          adjustments = {tag: k, products: generate_products(v[:discount], v[:coupon])}
          #STDERR << adjustments.inspect
          [k, adjustments.merge(v)]
        }]
      end 

      def org_sizes
        @@org_sizes ||= generate_org_sizes
      end 
    end

    before do
      redirect request.url.sub(/\/nathanaeljones\.com/, '/www.nathanaeljones.com'), 301 if request.host.start_with?("nathanaeljones.com")
      #store_version! if request.path.start_with?("/docs/v")
      cache_for(dev? ? 30 : 60 * 60 * 24) #1 day
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

    get '/pricing/for/:tag' do |tag|
      sizes = org_sizes
      request[:org] = sizes[tag]

      select_menu = '/pricing'
      render_file('/pricing/for')
    end

    get %r{/google([0-9a-z]+).html?} do |code|
      "google-site-verification: google#{code}.html" if config.google_verify.include?(code)
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
        dev? ? block.call : Hardwired::JsOptimize.filter_includes(options,block.call)
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
      Hardwired::JsOptimize.create_combined_response(Site, scripts, no_minify: dev?)
    end 

    #Fall back to having no version
    get '*' do
      output = render_file(request.path_info.gsub(/\/docs\/(v[0-9\.]+|latest)\//, ""))
      pass if output.nil?
      output 
    end 
end



module Hardwired
  class Template
    def hidden?
      flag?('hidden') or draft?
    end

    def edition
      Hardwired::Index["/plugins/editions/#{meta.edition}"]
    end

    def edition_plugins
      @edition_plugins ||= Hardwired::Index.enum_files { |p| p.path.start_with?("/docs/#{DEFAULT_DOCS_VERSION}/plugins") && p.is_page? && p.can_render? && !meta.edition.nil? && !p.meta.edition.nil? && meta.edition.casecmp(p.meta.edition) == 0 && !p.flag?('edition')}.to_a.sort { |x, y| y.meta.sort_field <=> x.meta.sort_field }
    end
  
  end
end

