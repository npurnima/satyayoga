class CreateUsercourses < ActiveRecord::Migration
  def up
        create_table :usercourses do |t|
        t.integer :user_id
        t.integer :course_id
        t.integer :No_of_names_per_day
        t.integer :guide_id

        t.timestamps
        end
  end

  def down
  end
end
