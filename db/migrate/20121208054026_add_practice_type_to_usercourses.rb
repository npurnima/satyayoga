class AddPracticeTypeToUsercourses < ActiveRecord::Migration
  def change
    add_column :usercourses, :practice_type, :string
  end
end
