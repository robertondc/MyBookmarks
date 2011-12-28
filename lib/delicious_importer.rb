require 'hpricot'

class DeliciousImporter

  def initialize(delicious_html)
    @delicious_html = delicious_html
  end

  def import
    doc = Hpricot(@delicious_html)
    doc.search("//a").each do |link|
        delicious_url = link.attributes['href']
        delicious_creation_date = Time.at(link.attributes['add_date'].to_i)
        delicious_tags = link.attributes['tags'].gsub(","," ")
        delicious_title = link.inner_html
        bookmark = Bookmark.new(:url => delicious_url, :title => delicious_title, :created_at => delicious_creation_date)
        tag_consistency = TagConsistency.new(delicious_tags) 
        tag_consistency.all.each do |tag|
          bookmark.tags << tag
        end
        bookmark.save!
    end
  end


end