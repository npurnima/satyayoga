class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :date_of_birth, :datetime
    add_column  :users, :street_address, :string
    add_column  :users, :city_address, :string
    add_column  :users, :state, :string
    add_column  :users, :zip_code, :integer
    add_column  :users, :country, :string
    add_column  :users, :email, :string
    add_column  :users, :phone_number, :integer
    add_column  :users, :photo, :string
    add_column  :users, :voice_request, :string
    add_column  :users, :salt,:string
  end
end
