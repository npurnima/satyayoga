class AddColumnToUserrole < ActiveRecord::Migration
  def change
    add_column :userroles, :guide_id, :integer
  end
end
