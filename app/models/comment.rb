class Comment < ApplicationRecord
  validates :body, length: {maximum: 500}, presence: true

  belongs_to :user, dependent: :destroy
  validates :user, presence: true

  belongs_to :commentable, polymorphic: true
  validates :commentable, presence: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
