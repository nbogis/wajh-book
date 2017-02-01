class Posting < ApplicationRecord

  belongs_to :postable, polymorphic: true
  validates :postable, presence: true

  belongs_to :user
  validates :user, presence: true

end
