class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :home_place
      t.string :current_place
      t.string :college
      t.string :high_school
      t.string :about_me
      t.string :interests
      t.string :relationship
      t.string :work
      t.string :languages
      t.string :phone
      t.date :dob

      t.timestamps
    end
  end
end
