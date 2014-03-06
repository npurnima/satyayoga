class AddFieldsToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :month, :integer
    add_column :magazines, :year, :integer
  end
end
