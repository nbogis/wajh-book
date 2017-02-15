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
      puts "you can add your friend"
      true
    end
  end

  def self.get_friendship_record(requester,receiver)
    self.find_by_friender_id_and_friend_id(requester.id,receiver.id)
  end

  def self.request_friendship(requester, receiver)
    if self.can_add_friend?(requester, receiver)
      # add two records specifying the requested and pending status
      self.create(:friender_id => requester.id,
                       :friend_id => receiver.id,
                       :status => "requested")
      self.create(:friender_id => receiver.id,
                       :friend_id => requester.id,
                       :status => "pending")
    end
  end

  def self.accept_friendship(requester, receiver)
    friendship_record = self.get_friendship_record(receiver,requester)
    if friendship_record.status == "pending"
      friendship_record.status = "accepted"
      friendship_record.save!

      # update the friendship from the other side too
      friendship_record = self.get_friendship_record(requester,receiver)
      friendship_record.status = "accepted"
      friendship_record.save!
    end
  end

  def self.reject_friendship(requester, receiver)
    friendship_record = self.get_friendship_record(receiver, requester)
    puts friendship_record
    if friendship_record.status == "pending"
      friendship_record.status = "rejected"
      friendship_record.save!
      # reject the opposite record
      friendship_record = self.get_friendship_record(requester,receiver)
      friendship_record.status = "rejected"
      friendship_record.save!
    end
  end

  def self.delete_friend(requester, receiver)
    friendship_record = self.get_friendship_record(requester, receiver)
    if friendship_record.status == "accepted"
      friendship_record.delete()

      friendship_record = self.get_friendship_record(receiver, requester)
      friendship_record.delete()
    end
  end

end
