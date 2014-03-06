class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :caption
      t.string :coverpage

      t.timestamps
    end
  end
end
