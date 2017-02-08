class Picture < ApplicationRecord
  validates :details, length: {maximum: 700}

  has_many :postings, as: :postable, :dependent => :destroy
  has_many :authors, through: :postings, source: :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :file, :styles => {:large => "600x600", :medium => "300x300", :thumb => "100x100"}
  validates_attachment_content_type :cover_pic, :content_type => /\Aimage\/.*\Z/
end
