class Post < ApplicationRecord
  validates :body,  :presence => true, length: {maximum: 700}
  # validates :user_id, :presence => true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
