class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 5..15

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  validates :password, presence: true, :allow_nil => true

  has_one :profile, dependent: :destroy

  has_many :postings, dependent: :destroy

  has_many :text_posts, through: :postings, source: :postable, source_type: "Post", dependent: :destroy
  has_many :pic_posts, through: :postings, source: :postable, source_type: "Picture", dependent: :destroy

  # comment doesn't need to have a polymorphic source in the user perspective. We would like to see the comments the user made but we don't want to see how many comments on post the user did for example. We would implement the comment like likes if we want it that way
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  # there is no need for a likings table since like does't take many forms. However, we want to know how many likes a post or comment has meaning the source is polymorphic.
  # has_many :liked_text_posts, through: :likes, source: :likeable, source_type: "Post", dependent: :destroy
  # has_many :likes_comments, through: :likes, source: :likeable, source_type: "Comment", dependent: :destroy

  # Setup friending initiated side
  # the friends I initiated friendings from
  has_many  :initiated_friendings, :foreign_key => :friender_id,
                                   :class_name => "Friending"
  # the friends who received the user initiated request
  has_many :friended_users, :through => :initiated_friendings,
                            :source => :friend_recipient

  # Setup friending receiver side
  # the friends who received the friending request
  has_many :received_friendings, :foreign_key => :friend_id,
                                 :class_name => "Friending"
  # the friend who initiated the received request
  has_many :users_friended_by, :through => :received_friendings,
                               :source => :friend_initiator

  after_create :create_profile

end
