class AddColumnToPractices < ActiveRecord::Migration
  def change
    add_column :practices, :guide_id, :integer
  end
end
