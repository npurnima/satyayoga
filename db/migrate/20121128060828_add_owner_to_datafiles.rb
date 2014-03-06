class AddOwnerToDatafiles < ActiveRecord::Migration
  def change
    add_column :datafiles, :owner, :integer
  end
end
