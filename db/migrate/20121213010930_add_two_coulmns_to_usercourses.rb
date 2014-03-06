class AddTwoCoulmnsToUsercourses < ActiveRecord::Migration
  def change
    add_column :usercourses, :practice_start_date, :datetime
    add_column :usercourses, :practice_time, :integer
    add_column :usercourses, :rest_time, :integer
  end
end
