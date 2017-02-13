class Friending < ApplicationRecord

  belongs_to :friend_initiator, :foreign_key => :friender_id,
                                :class_name => "User"

  belongs_to :friend_recipient, :foreign_key => :friend_id,
                                :class_name => "User"

  # make the composite key unique
  validates :friend_id, :uniqueness => { :scope => :friender_id }

  def self.can_add_friend?(requester, receiver)
    if requester == receiver
      puts "can't friend yourself"
      false
    elsif requester.friended_users.include?(receiver) ||  receiver.friended_users.include?(requester)
      puts "a friendhsip request already exist"
      false
    else
      requester.friended_users << receiver
      puts "you can add your friend"
      true
    end
  end
end
