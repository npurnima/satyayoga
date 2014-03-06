class AddFieldsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :owner, :integer
  end
end
