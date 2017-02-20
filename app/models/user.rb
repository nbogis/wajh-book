class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 5..15

  validates :username, :email, presence: true, uniqueness: true

  validates :password, :password_confirmation, presence: true

  has_one :profile, dependent: :destroy

  has_many :postings, dependent: :destroy

  has_many :text_posts, through: :postings, source: :postable, source_type: "Post", dependent: :destroy
  has_many :pic_posts, through: :postings, source: :postable, source_type: "Picture", dependent: :destroy

  # comment doesn't need to have a polymorphic source in the user perspective. We would like to see the comments the user made but we don't want to see how many comments on post the user did for example. We would implement the comment like likes if we want it that way
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  # Setup friending initiated side
  # the friends I initiated friendings from
  has_many  :initiated_friendings, :foreign_key => :friender_id,
                                   :class_name => "Friending",
                                   :dependent => :destroy
  # the friends who received the user initiated request
  has_many :friended_users, :through => :initiated_friendings,
                            :source => :friend_recipient

  # Setup friending receiver side
  # the friends who received the friending request
  has_many :received_friendings, :foreign_key => :friend_id,
                                 :class_name => "Friending",
                                 :dependent => :destroy
  # the friend who initiated the received request
  has_many :users_friended_by, :through => :received_friendings,
                               :source => :friend_initiator

  after_create :create_profile

  scope :get_all_users, -> {
      User.all
  }

  scope :find_friends_with_status, -> (user, status) {
    User.joins("JOIN Friendings ON users.id = Friendings.friend_id").where("friender_id = ?", user.id).where("status =?",status)
  }

  def self.is_friend?(user_1, user_2)
    if find_friends_with_status(user_1, "accepted").include?(user_2)
      true
    else
      false
    end
  end

  def self.can_add_friend?(user_1, user_2)
    if user_1 == user_2
      puts "can't friend yourself"
      false
    elsif user_1.friended_users.include?(user_2) ||  user_2.friended_users.include?(user_1)
      puts "a friendhsip request already exist"
      false
    else
      puts "you can add your friend"
      true
    end
  end

  def self.request_friend(requester, receiver)
    if self.can_add_friend?(requester, receiver)
      # add two records specifying the requested and pending status
      Friending.create(:friender_id => requester.id,
                       :friend_id => receiver.id,
                       :status => "requested")
      Friending.create(:friender_id => receiver.id,
                       :friend_id => requester.id,
                       :status => "pending")
    end
  end

  def self.accept_friend(requester, receiver)
    friendship_record = Friending.get_friendship_record(receiver,requester)
    if friendship_record.status == "pending"
      friendship_record.status = "accepted"
      friendship_record.save!

      # update the friendship from the other side too
      friendship_record = Friending.get_friendship_record(requester,receiver)
      friendship_record.status = "accepted"
      friendship_record.save!
    end
  end

  def self.reject_friend(requester, receiver)
    friendship_record = Friending.get_friendship_record(receiver, requester)
    puts friendship_record
    if friendship_record.status == "pending"
      friendship_record.status = "rejected"
      friendship_record.save!
      # reject the opposite record
      friendship_record = Friending.get_friendship_record(requester, receiver)
      friendship_record.status = "rejected"
      friendship_record.save!
    end
  end

  def self.delete_friend(requester, receiver)
    friendship_record = Friending.get_friendship_record(requester, receiver)
    if friendship_record.status == "accepted"
      friendship_record.delete()

      friendship_record = Friending.get_friendship_record(receiver, requester)
      friendship_record.delete()
    end
  end

end
