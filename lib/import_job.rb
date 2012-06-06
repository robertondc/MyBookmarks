class ImportJob
  @queue = :import
  
  def self.perform(bookmark_fields)
    bookmark = Bookmark.new(:url => bookmark_fields["url"], :title => bookmark_fields["title"], :created_at => bookmark_fields["creation_date"])
    tag_consistency = TagConsistency.new(bookmark_fields["tags"]) 
    tag_consistency.all.each do |tag|
      bookmark.tags << tag
    end
    bookmark.save
    task = ImportTask.find(bookmark_fields["import_task_id"])
    task.partial += 1
    task.save
  end
  
end