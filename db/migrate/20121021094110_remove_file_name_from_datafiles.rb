class RemoveFileNameFromDatafiles < ActiveRecord::Migration
  def up
    remove_column :datafiles, :fileName
  end

  def down
    add_column :datafiles, :fileName, :string
  end
end
