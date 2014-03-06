class AddOwnerToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :owner, :integer
  end
end
