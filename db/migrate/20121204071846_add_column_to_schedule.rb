class AddColumnToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :date, :date
  end
end
