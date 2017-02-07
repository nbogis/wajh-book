class AddProfilePicColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :profile_pic, :integer
    remove_column :users, :cover_pic, :integer

    add_attachment :profiles, :profile_pic
    add_attachment :profiles, :cover_pic
  end
end
