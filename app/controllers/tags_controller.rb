class TagsController < ApplicationController
  
  def index
    respond_to do |format|
      format.json  { render :json => Tag.where('name like ?', "#{params[:name].downcase}%").map{|tag| tag.name}.to_json }
    end
  end
  
end