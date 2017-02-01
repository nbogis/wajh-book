class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :comments, :commentable, polymorphic: true, index: true

  end
end
