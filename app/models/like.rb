class Like < ApplicationRecord

  belongs_to :likeable, polymorphic: true

  validates :likeable, presence: true
end
