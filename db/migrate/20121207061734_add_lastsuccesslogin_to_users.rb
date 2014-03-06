class AddLastsuccessloginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_succ_login, :datetime
  end
end
