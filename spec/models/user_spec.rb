require 'rails_helper'

describe User, :type => :model  do
  let(:user) { build(:user) }

  context "attributes validations" do
    it "succeed to create user with username, password, and password_confirmation" do
      expect(user).to be_valid
    end

    it "is invalid without username" do
      new_user = build(:user, username: nil)
      expect(new_user).not_to be_valid
    end

    it "is invalid without email" do
      new_user = build(:user, email: nil)
      expect(new_user).not_to be_valid
    end

    it "is invalid without password" do
      new_user = build(:user, password: nil)
      expect(new_user).not_to be_valid
    end

    it "is invalid without password confirmation" do
      new_user = build(:user, password_confirmation: nil)
      expect(new_user).not_to be_valid
    end

    it "validates password length is between 5..15" do
      should validate_length_of(:password).is_at_least(5).is_at_most(15)
    end
  end

  context "when saving multiple users" do
    before do
      user.save!
    end

    it "with duplicate email is invalid" do
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end

    it "with duplicate username is invalid" do
      new_user = build(:user, username: user.username)
      expect(new_user).not_to be_valid
    end
  end

  context "model associations" do
    it { should have_one(:profile).dependent(:destroy) }

    it { should have_many(:postings).dependent(:destroy) }

    it { should have_many(:text_posts).dependent(:destroy) }

    it { should have_many(:pic_posts).dependent(:destroy) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    end
end
