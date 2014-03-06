class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :street_address, :string
    add_column  :events, :city_address, :string
    add_column  :events, :state, :string
    add_column  :events, :zip_code, :integer
    add_column  :events, :country, :string
    add_column  :events, :email, :string
    add_column  :events, :phone_number, :integer
  end
end
