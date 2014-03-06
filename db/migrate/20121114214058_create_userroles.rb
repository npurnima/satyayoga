class CreateUserroles < ActiveRecord::Migration
  def change
    create_table :userroles do |t|
      t.integer :user_id
      t.integer :role_id
      t.string :assigned_by

      t.timestamps
    end
  end
end
