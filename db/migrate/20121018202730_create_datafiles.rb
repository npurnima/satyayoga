class CreateDatafiles < ActiveRecord::Migration
  def change
    create_table :datafiles do |t|
         t.string :fileName
         t.string :filePath
      t.timestamps
    end
  end
end
