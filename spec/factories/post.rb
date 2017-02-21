FactoryGirl.define do
  factory :post, class: :post do
    body {Faker::Lorem.paragraph(3)}
  end

  factory :long_post, class: :post do
    body {Faker::Lorem.paragraph(800)}
  end
end
