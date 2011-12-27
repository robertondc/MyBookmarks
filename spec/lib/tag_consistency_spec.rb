require 'spec_helper'

describe TagConsistency do
    
  describe "new tags" do
    it "must return new tags when the tags no exists" do
      tag_a = Tag.new(:name => "a")
      tag_b = Tag.new(:name => "b")
      tag_b.save!
      TagConsistency.new("a b").new_tags.first.should == tag_a
    end

    it "must no return a new tag when the tag exist" do
      tag_a = Tag.new(:name => "a")
      tag_a.save!
      tag_b = Tag.new(:name => "b")
      tag_b.save!
      TagConsistency.new("a b").new_tags.size.should == 0
    end
  end

  describe "existent tags" do
    it "must return a existent tag when the tag exist" do
      tag_a = Tag.new(:name => "a")
      tag_a.save!
      TagConsistency.new("a b c").existent_tags.first.should == tag_a
    end

    it "must no return a existents tags when the tags no exist" do
      TagConsistency.new("a b c").existent_tags.size.should == 0
    end
  end

  describe "removed from" do
    it "must return the deleted tags from a tag list" do
      tag_a = Tag.new(:name => "a")
      tag_b = Tag.new(:name => "b")
      tag_c = Tag.new(:name => "c")
      tags = [tag_a,tag_b,tag_c]
      TagConsistency.new("b c").removed_from(tags).first.should == tag_a
    end

    it "must no return the deleted tags when all tags are present in the tag list" do
      tag_a = Tag.new(:name => "a")
      tag_b = Tag.new(:name => "b")
      tag_c = Tag.new(:name => "c")
      tags = [tag_a,tag_b,tag_c]
      TagConsistency.new("a b c").removed_from(tags).size.should == 0
    end
  end
  
end
