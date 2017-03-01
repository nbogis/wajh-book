require 'rails_helper'

describe ProfilesController do
  let(:user) { create(:user) }

  describe 'PUT #update', focus: true do
    let(:put_update_valid) do
      put :update, user_id: user.id,
        profile: {
          home_place: "Riyadh",
          current_place: "Washington, DC",
          college: "GWU",
          languages: "Spanish"
        }
    end

    let(:put_update_invalid) do
      put :update, user_id: user.id,
        profile: {
          about_me: "abc"*500
        }
    end

    context "user is logged in" do
      before do
        sign_in user
      end

      context 'attributes are valid' do
        before do
          put_update_valid
          user.reload
        end

        it "updates the user's profile" do
          expect(user.profile.home_place).to eq("Riyadh")
          expect(user.profile.current_place).to eq("Washington, DC")
          expect(user.profile.college).to eq("GWU")
          expect(user.profile.languages).to eq("Spanish")
        end

        it "redirect to user's profile path" do
          expect(response).to redirect_to user_profile_path(user)
        end

        it "sets a success flash" do
          expect(flash[:success]).to_not be_nil
        end
      end

      context "attributes are invalid" do
        before do
          put_update_invalid
          user.reload
        end

        it "doesn't update the user's profile" do
          expect(user.profile.about_me).to be_nil
        end

        it "renders the edit template" do
          expect(response).to render_template :edit
        end

        it "sets an error flash" do
          expect(flash[:error]).to_not be_nil
        end
      end
    end
    context "user not logged in" do
      before do
        put_update_valid
        user.reload
      end

      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an error flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
