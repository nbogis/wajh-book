class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :details
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_attachment :pictures, :file
  end
end
