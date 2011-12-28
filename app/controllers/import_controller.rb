class ImportController < ApplicationController
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end
  
  def create
    delicious_html = params['import']['upload'].read
    DeliciousImporter.new(delicious_html).import
  end
  
end
