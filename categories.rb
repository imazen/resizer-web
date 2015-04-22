
module Hardwired
  class Template



    def after_load
      #Evaluate all categories, assign meta.sidebar and meta.primary_category
      @@cats ||= Hardwired::Config.config.categories
      @@cats_by_tag ||= Hash[@@cats.map{ |c| [c.tag.to_s,c] }]

      matches = @@cats.select do |c|
        tag?(c.tag) || [c.include].flatten.select { |p| path.start_with?(p) }.length > 0
      end

      unless matches.empty? 
        #Join with existing category tags
        meta.categories = (meta.categories || []) | matches.map { |c| c.tag }

        #Select the first category from the union
        meta.category ||= meta.categories.first

        c = @@cats_by_tag[meta.category]

        #Clone all specified metadata, without overwriting anything
        @meta = RecursiveOpenStruct.new(c.meta.to_hash.merge((meta || {}).to_hash)) unless c.nil? || c.meta.nil?
    
        #p "Categorized #{path} as #{meta.categories * ','}  (primary #{meta.category})"

        #Add the primary category to the tags
        meta.tags = tags | [meta.category]
      end
        
    end
  end
end



module Tilt

  class KramdownTemplate < Template


    def prepare
      options[:smart_quotes] = DUMB_QUOTES unless options[:smartypants]

      options[:input] = :GFM
      options[:hard_wrap] = false
      @engine = Kramdown::Document.new(data, options)
      @output = nil
    end
  end
end
