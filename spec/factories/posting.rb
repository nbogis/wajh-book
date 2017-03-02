FactoryGirl.define do
  factory :posting do
    user

    factory :text_posts do
      association :postable, factory: :post
    end

    factory :pic_posts do
      association :postable, factory: :picture
    end
  end
end
