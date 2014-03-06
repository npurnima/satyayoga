class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email_from
      t.string :email_to
      t.string :email_subject
      t.string :email_cc
      t.string :email_bcc
      t.text :email_body
      t.string :email_attachment

      t.timestamps
    end
  end
end
