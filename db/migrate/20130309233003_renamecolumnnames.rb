class Renamecolumnnames < ActiveRecord::Migration
  def change
      rename_column :courses, :filePath, :filepath

      rename_column :magazines, :filePath, :filepath
  end

end
