class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
