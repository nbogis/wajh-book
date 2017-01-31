class Like < ApplicationRecord

  belongs_to :user
  validates :user, presence: true

  belongs_to :likeable, polymorphic: true
  validates :likeable, presence: true
end
