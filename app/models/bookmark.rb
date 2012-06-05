class Bookmark < ActiveRecord::Base
  attr_accessible :url, :title, :created_at, :text_tags
  has_and_belongs_to_many :tags
  validates_presence_of :url, :title
  before_save :validate_http_prefix
  after_destroy :remove_no_references_tags
  
  def text_tags=(text_tags)
    tag_consistency = TagConsistency.new(text_tags)
    tag_consistency.all.each do |tag|
      tags << tag if tags.exclude?(tag)
    end
    tag_consistency.removed_from(tags).each do |tag|
      tags.delete(tag)
    end
  end
  
  def text_tags
    tags.collect{|t| t.name}.join(" ")
  end
  
  def validate_http_prefix
    self.url = "http://#{url}" unless url =~ /http:\/{2}/
  end
  
  def to_s
    "#{self.inspect}-#{tags}"
  end
  
  def remove_no_references_tags
    Tag.all.each {|tag| tag.destroy if tag.bookmarks.size == 0}
  end
  
end