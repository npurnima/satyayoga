class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.datetime :date
      t.integer :course_id
      t.integer :course_from_number
      t.integer :course_to_number
      t.integer :user_id
      t.string :experience
      t.string :text

      t.timestamps
    end
  end
end
