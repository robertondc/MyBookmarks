class Tag < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :bookmarks
  
  def ==(other_tag)
    self.name == other_tag.name
  end

  def to_s
    self.name
  end
   
end