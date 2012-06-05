class ImportController < ApplicationController
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
      format.json {render :json => rand(1..100).to_json}
    end
  end
  
  def create
    delicious_html = params['import']['upload'].read
    DeliciousImporter.new(delicious_html).import
  end
    
end
