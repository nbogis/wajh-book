class Profile < ApplicationRecord

  belongs_to :user

  validates :about_me, length: {maximum: 500}
end
