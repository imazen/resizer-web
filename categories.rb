
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

        #Set the default sidebar and appendix based on the primary category
        meta.sidebar ||= c.sidebar
        meta.append ||= c.append
    
        p "Categorized #{path} as #{meta.categories * ','}  (primary #{meta.category})"

        #Add the primary category to the tags
        meta.tags = tags | [meta.category]
      end
        
    end
  end
end

