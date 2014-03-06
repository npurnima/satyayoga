class AddGroupLeaderToUserroles < ActiveRecord::Migration
  def change
    add_column :userroles, :group_leader, :string
  end
end
