class AddOwnerToPractices < ActiveRecord::Migration
  def change
    add_column :practices, :owner, :integer
  end
end
