class TagConsistency

  def initialize(text_tags)
    @tag_names = text_tags.split
  end

  def all
    new_tags + existent_tags
  end

  def new_tags
    all_tags = Tag.all
    new_tags = []
    @tag_names.each do |tag_name|
        new_tags << Tag.new(:name => tag_name) if all_tags.select{|t| t.name == tag_name}.empty?
    end
    new_tags
  end

  def existent_tags
    all_tags = Tag.all
    existent_tags = []
    @tag_names.each do |tag_name|
      existent = all_tags.select{|t| t.name == tag_name}
      existent_tags << existent.first unless existent.empty?
    end
    existent_tags
  end

  def removed_from(tags)
    removed_tags = []
    tags.each do |tag|
      removed_tags << tag if @tag_names.exclude?(tag.name)
    end
    removed_tags
  end

end