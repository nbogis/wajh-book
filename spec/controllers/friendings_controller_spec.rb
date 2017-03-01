require 'rails_helper'

describe FriendingsController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe "POST #create", focus: true do
    let(:friending_create_valid) do
      sign_in user

      post :create, :id => another_user.id
    end

    context "when user is logged in" do
      it "succeed to create friending record" do
        expect { friending_create_valid }.to change(Friending, :count).by(1)
      end
    end
  end
end
