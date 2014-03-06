class AddOwneToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :owner, :integer
  end
end
