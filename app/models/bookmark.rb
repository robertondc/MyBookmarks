class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates_presence_of :url, :title
  
  def tags_inline=(text_tags)
    new_tags = text_tags.split
    existent_tags = Tag.all
    new_tags.each do |tag_name|
      if tags.select{|t| t.name == tag_name}.empty?
        existent_tag = existent_tags.select{|t| t.name == tag_name}
          if existent_tag.empty?
            tags << Tag.new(:name => tag_name)
          else
            tags << existent_tag.first
          end
      end
    end
  end
  
  def tags_inline
    tags.collect{|t| t.name}.join(" ")
  end
  
end