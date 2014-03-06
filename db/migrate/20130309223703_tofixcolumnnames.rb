class Tofixcolumnnames < ActiveRecord::Migration
  def change

    rename_column :magazines, :languageWritten, :languagewritten
    rename_column :magazines, :dateWritten, :datewritten
    rename_column :magazines, :coverPageImage, :coverpageimage

    rename_column :events, :startTime, :starttime
    rename_column :events, :endTime, :endtime

    rename_column :datafiles, :filePath, :filepath

    rename_column :usercourses, :No_of_names_per_day, :no_of_names_per_day

  end


end
