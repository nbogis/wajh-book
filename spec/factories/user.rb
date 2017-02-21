FactoryGirl.define do
  factory :user do |u|
    u.sequence(:username) { |n| "Foo_#{n}"}
    u.sequence(:email) { |n| "foo_#{n}@bar.com"}
    u.password "password"
    u.password_confirmation "password"
  end
end
