class AddOwnerToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :owner, :integer
  end
end
