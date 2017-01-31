class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :text_posts, through: :postings, source: :postable, source_type: "Post", dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_text_posts, through: :likings, source: :likeable, source_type: "Post", dependent: :destroy
  has_many :likes_comments, through: :linkings, source: :likeable, source_type: "Comment", dependent: :destroy

end
