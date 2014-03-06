class AddTitleToDatafiles < ActiveRecord::Migration
  def change
    add_column :datafiles, :title, :string
  end
end
