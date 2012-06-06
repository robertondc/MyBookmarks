require 'hpricot'

class DeliciousImporter

  def initialize(delicious_html)
    @delicious_html = delicious_html
  end

  def import(import_task)
    doc = Hpricot(@delicious_html)
    doc.search("//a").each do |link|
        url = link.attributes['href']
        creation_date = Time.at(link.attributes['add_date'].to_i)
        tags = link.attributes['tags'].gsub(","," ")
        title = link.inner_html
        Resque.enqueue(ImportJob, {url: url, creation_date: creation_date, tags: tags, title: title, import_task_id: import_task.id})
        import_task.total += 1
        import_task.save
    end
  end


end