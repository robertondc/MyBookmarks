class CreateImportTasks < ActiveRecord::Migration
  def change
    create_table :import_tasks do |t|
      t.integer :total, :default => 0
      t.integer :partial, :default => 0
      t.string :file_name
      t.integer :file_size
      t.timestamps
    end
  end
end
