class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :location
      t.timestamp :startTime
      t.timestamp :endTime
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
