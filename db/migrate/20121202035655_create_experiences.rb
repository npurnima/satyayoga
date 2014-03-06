class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :topic
      t.integer :owner
      t.text :description
      t.integer :no_of_views

      t.timestamps
    end
  end
end
