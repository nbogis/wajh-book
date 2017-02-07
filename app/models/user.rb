class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 5..15

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  has_one :profile, dependent: :destroy

  has_many :postings, dependent: :destroy
  has_many :text_posts, through: :postings, source: :postable, source_type: "Post", dependent: :destroy

  # comment doesn't need to have a polymorphic source in the user perspective. We would like to see the comments the user made but we don't want to see how many comments on post the user did for example. We would implement the comment like likes if we want it that way
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  # there is no need for a likings table since like does't take many forms. However, we want to know how many likes a post or comment has meaning the source is polymorphic.
  # has_many :liked_text_posts, through: :likes, source: :likeable, source_type: "Post", dependent: :destroy
  # has_many :likes_comments, through: :likes, source: :likeable, source_type: "Comment", dependent: :destroy

  after_create :create_profile

end
