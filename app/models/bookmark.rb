class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates_presence_of :url, :title
    
  def tags_inline=(text_tags)
    tag_consistency = TagConsistency.new(text_tags)
    tag_consistency.all.each do |tag|
      tags << tag if tags.exclude?(tag)
    end
    tag_consistency.removed_from(tags).each do |tag|
      tags.delete(tag)
    end
  end
  
  def tags_inline
    tags.collect{|t| t.name}.join(" ")
  end
  
end