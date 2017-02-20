class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 5..15

  validates :username, :email, presence: true,uniqueness: true

  validates :password, :password_confirmation, presence: true

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
  # the friends I initiated friendings with
  has_many  :initiated_friendings, -> { where  status: "requested"  },
                                   :foreign_key => :friender_id,
                                   :class_name => "Friending",
                                   :dependent => :destroy

  # records of all the user I requested friends with
  has_many :requested_friends, :through => :initiated_friendings,
                            :source => :friend_recipient

  # Setup friending receiver side
  has_many :received_friendings, -> { where status: "requested" },
                                 :foreign_key => :friend_id,
                                 :class_name => "Friending",
                                 :dependent => :destroy

  # records of all the friends that requested my friending and waiting for me too accept
  has_many :pending_friends, :through => :received_friendings,
                             :source => :friend_initiator

  # The record of rejections
  has_many :rejected_friendings, -> { where status: "rejected" },
                                :foreign_key => :friend_id,
                                :class_name => "Friending",
                                :dependent => :destroy

  # records of all the users that have rejection status with me
  has_many :rejected_friends, :through => :rejected_friendings,
                              :source => :friend_initiator

  # records in friending that have accepted status
  has_many :accepted_friending, -> { where status: "accepted" },
                                :foreign_key => :friend_id,
                                :class_name => "Friending",
                                :dependent => :destroy

  # records of all the users that I'm friend with
  has_many :friends, :through => :accepted_friending,
                     :source => :friend_initiator

  after_create :create_profile

  scope :get_all_users, -> {
      User.all
  }

  def self.is_friend?(user_1, user_2)
    if user_1.friends.include?(user_2)
      true
    else
      false
    end
  end

  def self.can_add_friend?(user_1, user_2)
    if user_1 == user_2
      puts "can't friend yourself"
      false
    elsif user_1.pending_friends.include?(user_2) ||  user_1.requested_friends.include?(user_2)
      puts "a friendhsip request already exist"
      false
    elsif user_1.friends.include?(user_2)
      puts "you are already friends"
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
    end
  end

  def self.accept_friend(requester, receiver)
    friendship_record = Friending.get_friendship_record(requester,receiver)
    if friendship_record.status == "requested"
      friendship_record.status = "accepted"
      friendship_record.save!

      # update the friendship from the other side too
      friendship_record = Friending.create(:friender_id => receiver.id,
                       :friend_id => requester.id,
                       :status => "accepted")
      friendship_record.save!
    end
  end

  def self.reject_friend(requester, receiver)
    friendship_record = Friending.get_friendship_record(requester, receiver)
    puts friendship_record
    if friendship_record.status == "requested"
      friendship_record.status = "rejected"
      friendship_record.save!
      # reject the opposite record
      friendship_record = Friending.create(:friender_id => receiver.id,
                       :friend_id => requester.id,
                       :status => "rejected")
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
