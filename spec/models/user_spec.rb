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

    it {should have_many(:pending_friends).dependent(:destroy)}

    it {should have_many(:requested_friends).dependent(:destroy)}

    it {should have_many(:rejected_friends).dependent(:destroy)}

    it {should have_many(:friends).dependent(:destroy)}

    end

  context "class methods" do
    subject {user}

    let(:second_user) { build(:user) }
    before do
      user.save!
      second_user.save!
    end

    it "returns false for users not being friends" do
      expect(subject.class.is_friend?(user,second_user)).to be_falsey
    end

    it "returns true for they can add each other" do
      expect(subject.class.can_add_friend?(user,second_user)).to be_truthy
    end

    it "add a requested record to friending when friend request is sent" do
      subject.class.request_friend(user,second_user)

      expect(Friending.where(friender_id: user, friend_id: second_user, status: "requested")).to exist
    end

    it "changes the requested record to accepted after accept friending" do
      subject.class.request_friend(user,second_user)
      subject.class.accept_friend(user,second_user)

      expect(Friending.where(friender_id: user, friend_id: second_user, status: "accepted")).to exist
    end

    it "adds another record with columns switch when user accepted a friend" do
      subject.class.request_friend(user,second_user)
      subject.class.accept_friend(user,second_user)

      expect(Friending.where(friend_id: user, friender_id: second_user, status: "accepted")).to exist
    end

    it "changes the requested record to rejected after reject friending"do
      subject.class.request_friend(user,second_user)
      subject.class.reject_friend(user,second_user)

      expect(Friending.where(friender_id: user, friend_id: second_user, status: "rejected")).to exist
    end

    it "adds another record with columns switch when user rejected a friend" do
      subject.class.request_friend(user,second_user)
      subject.class.reject_friend(user,second_user)

      expect(Friending.where(friend_id: user, friender_id: second_user, status: "rejected")).to exist
    end

    it "deletes friending record when unfriending a friend" do
      subject.class.request_friend(user,second_user)
      subject.class.accept_friend(user,second_user)
      subject.class.delete_friend(user,second_user)

      expect(Friending.where(friend_id: user, friender_id: second_user, status: "accepted")).not_to exist

      expect(Friending.where(friender_id: user, friend_id: second_user, status: "accepted")).not_to exist
    end
  end
end
