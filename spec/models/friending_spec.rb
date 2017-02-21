require 'rails_helper'

describe Friending, :type => :model  do
  let(:friending) { build(:friending) }

  context "attributes validations" do
    it "succeeds to create a friending record with friend_initiator and friend_recipient" do
      expect(friending).to be_valid
    end

    it "is invalid without friend_initiator" do
      new_friending = build(:friending, friend_initiator: nil)
      expect(new_friending).not_to be_valid
    end

    it "is invalid without friend_recipient" do
      new_friending = build(:friending, friend_recipient: nil)
      expect(new_friending).not_to be_valid
    end

    it "is invalid to have duplicate records" do
      friending.save!

      new_friending = build(:friending,
                      friend_initiator: friending.friend_initiator, friend_recipient: friending.friend_recipient)

      expect(new_friending).not_to be_valid
    end
  end

  context "tests associations" do
    it {should belong_to(:friend_initiator)}

    it {should belong_to(:friend_recipient)}
  end

  context "class methods" do
    subject {friending}
    before do
      friending.save!
    end

    it "returns the friendship record when requested" do
      record = subject.class.get_friendship_record(friending.friend_initiator, friending.friend_recipient)

      expect(record).not_to be_nil
    end

  end
end
