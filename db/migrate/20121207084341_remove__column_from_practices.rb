class RemoveColumnFromPractices < ActiveRecord::Migration
  def up
    remove_column :practices, :text
  end

  def down
    add_column :practices, :text, :text
  end
end
