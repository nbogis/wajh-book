FactoryGirl.define do
  factory :friending, class: :friending do
    association :friend_initiator, factory: :user, username: "foo_1", email: "foo_1@bar.com", password: "12345", password_confirmation: "12345"

    association :friend_recipient, factory: :user, username: "foo_2", email: "foo_2@bar.com", password: "12345", password_confirmation: "12345"
  end
end
