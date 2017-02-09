class Post < ApplicationRecord
  validates :body,  :presence => true, length: {maximum: 700}
  has_many :postings, as: :postable, :dependent => :destroy
  has_many :authors, through: :postings, source: :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

end
