FactoryGirl.define do
  factory :comment, class: :comment do
    body {Faker::Lorem.paragraph(3)}
  end

  factory :long_comment, class: :comment do
    body {Faker::Lorem.paragraph(550)}
  end
end
