class CreatePostings < ActiveRecord::Migration[5.0]
  def change
    create_table :postings do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :postings, :postable, polymorphic: true, index: true
  end
end
