class CreateExpcomments < ActiveRecord::Migration
  def change
    create_table :expcomments do |t|
      t.integer :exp_id
      t.integer :owner
      t.text :description
      t.integer :no_of_views
      t.string :comment_type

      t.timestamps
    end
  end
end
