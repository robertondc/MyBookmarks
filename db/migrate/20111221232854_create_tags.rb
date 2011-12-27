class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    create_table :bookmarks_tags, :id => false do |t|
      t.references :bookmark, :tag
    end
     remove_column :bookmarks, :tags
  end

  def self.down
    add_column :bookmarks, :tags, :string
    drop_table :tags
    drop_table :bookmarks_tags
  end
end
