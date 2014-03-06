class CreateEventcomments < ActiveRecord::Migration
  def change
    create_table :eventcomments do |t|
      t.integer :event_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
