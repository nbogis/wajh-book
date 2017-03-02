require 'rails_helper'

describe Picture, :type => :model  do
  let(:user) {create(:user)}
  let(:pic_post) { user.pic_posts.create(file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg")) }

  context "attributes validations" do

    it "succeeds to create a text post" do
      expect(pic_post).to be_valid
    end

    it "validates details length to be less than 700" do
      user.pic_posts.create(details: Faker::Lorem.paragraph(500))
      should validate_length_of(:details).is_at_most(700)
    end

    it "invalidates when details length is greater than 700" do
      new_post = user.pic_posts.create(details: Faker::Lorem.paragraph(800))
      expect(new_post).not_to be_valid
    end

    it "invalidates when file is not an image" do
      new_post = user.pic_posts.create(file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/index.html", "html"))
      expect(new_post).not_to be_valid
    end

  end

  context "tests associations", focus: true do

    it { should have_many(:postings) }

    it { should have_many(:authors) }

    it { should have_many(:comments) }

    it { should have_many(:likes) }

    it { should have_many(:likers) }

  end

end
