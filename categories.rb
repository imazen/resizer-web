
module Hardwired
  class Template


    def reachable_in_versions(versions)

      current_version = versions.select{|b| self.path.start_with?(b[:folder])}.first

      if current_version.nil?
        #STDERR << "#{self.path} not found in versioned folder\n"
        return [] 
      end

      versions.map do |hash|
        prefix = hash[:folder]
        rel_path = self.path[current_version[:folder].length..-1]
        other_version = prefix + rel_path
        dest = Hardwired::Aliases::AliasTable.get_final_destination(other_version, other_version) || other_version
        final_page = Hardwired::Index[dest]
        #STDERR << "#{other_version} mapped to #{dest} #{final_page.nil? ? '[missing!]' : '[exists]'}. \n"
        final_page.nil? ? nil : {active: hash == current_version, page_path: dest}.merge(hash)
      end.compact
    end 


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
