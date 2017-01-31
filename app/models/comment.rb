class Comment < ApplicationRecord

  validates :body, length: {maximum: 500}, presence: true
  # validates :user_id, presence: true

  belongs_to :commentable, polymorphic: true
  # validates :commentable, presence: true

  has_one :author, through: :commentings, source: :user
  has_many :likes, as: :likeable, dependent: :destroy
end
