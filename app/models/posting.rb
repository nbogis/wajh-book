class Posting < ApplicationRecord

  belongs_to :postable, polymorphic: true
  validates :postable, presense: true

  belongs_to :user
  validates :user, presense: true

end
