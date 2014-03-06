class UpdatePhonenumberFieldtype < ActiveRecord::Migration
  def change
     change_column :events, :phone_number, :string, :null=>'false'
     change_column :users, :phone_number, :string

  end
end
