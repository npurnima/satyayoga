class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
       t.string :name
       t.text :filePath

      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end
