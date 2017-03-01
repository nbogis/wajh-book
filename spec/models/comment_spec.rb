equire 'rails_helper'

describe Post, :type => :model  do
  let(:comment) { build(:comment)}

  context "attributes validations" do
    it "succeeds to create a comment with body"
  end
end
