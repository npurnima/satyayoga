class AddColumnsToUsercourses < ActiveRecord::Migration
  def change
    add_column :usercourses, :date, :date
    add_column :usercourses, :course_no_from, :integer
    add_column :usercourses, :course_no_to, :integer
    add_column :usercourses, :user_experiences, :text
  end
end
