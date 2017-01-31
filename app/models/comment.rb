class Comment < ApplicationRecord
  validates :body, length: {maximum: 500}, presence: true
  # validates :user_id, presence: true

  belongs_to :user, dependent: :destroy
  validates :user, presence: true

  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy
end
