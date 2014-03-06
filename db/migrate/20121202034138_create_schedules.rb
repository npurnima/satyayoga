class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :event_id
      t.string :title
      t.time :start_time
      t.time :end_time
      t.string :next_event

      t.timestamps
    end
  end
end
