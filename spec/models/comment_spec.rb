require 'rails_helper'

describe Comment, :type => :model  do

  let(:user) {create(:user)}
  let(:post) { user.text_posts.create(body: "new post")}
  let(:picture) { user.pic_posts.create(file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/test.jpg", "image/jpg")) }

  let(:post_comment) { post.comments.create(body: "nice post", user_id: user.id)}

  let(:picture_comment) { post.comments.create(body: "nice post", user_id: user.id)}

  context "attributes validations" do
    it "succeeds to create a comment with valid attributes" do
      expect(post_comment).to be_valid
    end

    it "succeeds to create a comment on picture with valid attributes" do
      expect(picture_comment).to be_valid
    end

    it "validates body length to be less than 500" do
      post_comment
      should validate_length_of(:body).is_at_most(500)
    end

    it "invalidates when body is greater than 500" do
      comment = post.comments.create(body: Faker::Lorem.paragraph(600), user_id: user.id)
      expect(comment).not_to be_valid
    end

    it "invalidates to create a comment without body" do
      comment = post.comments.create(body: nil, user_id: user.id)

      expect(comment).to_not be_valid
    end

    it "invalidates to create a comment without user" do
      comment = post.comments.create(body: "nice post", user_id: nil)

      expect(comment).to_not be_valid
    end
  end

  context "tests associations" do

    it { should belong_to(:user) }

    it { should belong_to(:commentable) }

    it { should have_many(:likes) }

    it { should have_many(:likers) }
  end
end
