FactoryGirl.define do
  factory :posting, class: :posting do
    user = create(:user)

    # factory :text_posts do
    #   assocaition :postable, factory: :post
    # end
    #
    # factory :pic_posts do
    #   association :postable, factory: :picture
    # end
  end
end
