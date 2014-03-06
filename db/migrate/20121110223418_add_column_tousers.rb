class AddColumnTousers < ActiveRecord::Migration
  def up
    add_column  :users, :terms_accepted, :string
  end

  def down
  end
end
