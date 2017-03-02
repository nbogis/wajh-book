require 'rails_helper'

describe Like, :type => :model  do
  let(:user) {create(:user)}
  let(:post) { user.text_posts.create(body: "new post")}
  let(:like) { post.likes.create()}

  context "attributes validations" do

    it "succeeds to create a like to post" do
      expect(post).to be_valid
    end

  end
end
