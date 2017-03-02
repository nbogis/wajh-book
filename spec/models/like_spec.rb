require 'rails_helper'

describe Like, :type => :model  do
  let(:user) {create(:user)}
  let(:post) { user.text_posts.create(body: "new post")}
  let(:picture) { user.pic_posts.create(file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg")) }

  let(:post_like) { post.likes.create(user_id: user.id)}

  let(:pic_like) { picture.likes.create(user_id: user.id)}

  context "attributes validations" do

    it "succeeds to create a like to post" do
      post
      expect(post_like).to be_valid
    end

    it "succeeds to create a like to picture" do
      picture
      expect(pic_like).to be_valid
    end

    it "invalid when user is nil for text post" do
      like = post.likes.create(user_id: nil)
      expect(like).to_not be_valid
    end

    it "invalid when user is nil for picture post" do
      like = picture.likes.create(user_id: nil)
      expect(like).to_not be_valid
    end

  end

  context "tests associations" do

    it { should belong_to(:user) }

    it { should belong_to(:likeable) }
  end
end
