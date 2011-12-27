require 'spec_helper'

describe BookmarksController do
  
  def valid_attributes
    {:url => 'http://www.r7.com.br',:title => 'Rede Record',:tags => 'brazil news'}
  end
  
  describe "GET index" do
    it "assigns all bookmarks as @bookmarks" do
      #bookmark = Bookmark.create! valid_attributes
      #get :index
      #assigns(:bookmarks).should eq([bookmark])
    end
  end
  
end
