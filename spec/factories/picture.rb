FactoryGirl.define do
  factory :picture_post do
    file Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg")

  end
end
