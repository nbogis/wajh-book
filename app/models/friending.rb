class Friending < ApplicationRecord

  belongs_to :friend_initiator, :foreign_key => :friender_id,
                                :class_name => "User"

  belongs_to :friend_recipient, :foreign_key => :friend_id,
                                :class_name => "User"

  # make the composite key unique
  validates :friend_id, :uniqueness => { :scope => :friender_id }

  def self.get_friendship_record(requester,receiver)
    self.find_by_friender_id_and_friend_id(requester.id,receiver.id)
  end

end
