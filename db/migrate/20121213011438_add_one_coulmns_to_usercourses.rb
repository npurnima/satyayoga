class AddOneCoulmnsToUsercourses < ActiveRecord::Migration
  def change
    add_column :usercourses, :status, :string
  end
end
