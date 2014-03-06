class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :album
      t.string :title
      t.string :caption
      t.string :coverpage

      t.timestamps
    end
  end
end
