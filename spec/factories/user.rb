FactoryGirl.define do
  factory :user, :aliases => [:authors]  do
    username  "Foo"
    email       "foo@bar.com"
    password "password"
    password_confirmation "password"
  end
end
