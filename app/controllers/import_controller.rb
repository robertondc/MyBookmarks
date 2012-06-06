class ImportController < ApplicationController
  
  def index
    @import_tasks = ImportTask.order("created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end
  
  def create
    delicious_html = params['import']['upload'].read
    import_task = ImportTask.new
    import_task.file_name = params['import']['upload'].original_filename
    import_task.file_size = params['import']['upload'].size
    import_task.save
    DeliciousImporter.new(delicious_html).import(import_task)
  end

  def status
    task = ImportTask.find(params[:id])
    percentage = (task.partial * 100) / task.total
    respond_to do |format|
      format.json {render :json => percentage.to_json}
    end
  end
    
end
