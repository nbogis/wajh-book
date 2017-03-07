require 'rails_helper'

describe Profile, :type => :model  do
  let(:user) {create(:user)}

  context "attributes validations" do

    it "succeeds to update a profile"  do
      user.profile.update_attributes(college: "SLU")
      expect(user.profile.college).to eq("SLU")
    end

    it "validates about me length to be less than 500" do
      user.profile.update_attributes(about_me: Faker::Lorem.paragraph(100))
      should validate_length_of(:about_me).is_at_most(500)
    end

    it "invalidates when about me length is greater than 500" do
      user.profile.update_attributes(about_me: Faker::Lorem.paragraph(600))
      expect(user.profile.about_me).to be_nil
    end

    it "invalidates when profile image size is greater than 1MB" do
      user.profile.update_attributes(profile_pic: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg"))

      expect(user.profile.profile_pic).to be_nil
    end

    it "invalidates when cover image size is greater than 10MB" do
       user.profile.update_attributes(cover_pic: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg"))
      expect(user.profile.cover_pic).to be_nil
    end
    #
    it "invalidates when file is not an image" do
      user.profile.update_attributes(profile_pic: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/index.html", "html"))
      expect(user.profile.profile_pic).to be_nil
    end

  end

  context "tests associations" do

    # it { should have_many(:postings) }
    #
    # it { should have_many(:authors) }
    #
    # it { should have_many(:comments) }
    #
    # it { should have_many(:likes) }
    #
    # it { should have_many(:likers) }

  end

end
