class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :title
      t.string :caption
      t.integer :album_id, :null => false
      t.timestamps
    end
  end
  def down
    drop_table :photos
  end
end
