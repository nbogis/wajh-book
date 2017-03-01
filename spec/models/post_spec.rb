require 'rails_helper'

describe Post, :type => :model  do
  let(:user) {create(:user)}

  context "attributes validations" do

    it "succeeds to create a text post" do
      post = user.text_posts.create(body: "fefswewd")
      expect(post).to be_valid
    end

    it "invalidates when body is empty" do
      new_post = build(:post, body: nil)
      expect(new_post).not_to be_valid
    end

    it "invalidates when posting is empty" do
      new_post = build(:post, postings: nil)
      expect(new_post).not_to be_valid
    end

    it "validates body length to be less than 700" do
      should validate_length_of(:body).is_at_most(700)
    end

    it "invalidates when body is greater than 700" do
      new_post = build(:long_post)
      expect(new_post).not_to be_valid
    end
  end

  context "tests associations" do

    it { should have_many(:postings) }

    it { should have_many(:authors) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:commenters) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:likers)}
  end
end
