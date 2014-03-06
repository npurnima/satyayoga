class AddColumnToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :visited, :boolean
  end
end
