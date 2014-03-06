class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :title
      t.string :filePath
      t.string :coverPageImage
      t.string :languageWritten
      t.date :dateWritten
      t.timestamps
    end
  end
end
