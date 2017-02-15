module ProfilesHelper

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def friendship_request_existed?(requester, receiver)
    requester.friended_users.pluck(:friend_id).include?(receiver.id)
  end

  def same_user?(requester, receiver)
    requester == receiver
  end
end
