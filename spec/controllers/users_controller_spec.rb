require 'rails_helper'

describe UsersController do


  describe 'friending paths' do
    let(:user) { create(:user)}
    let(:another_user) {create(:user)}

    subject {user}

    context "request friending" do
      context "user logged in" do
        before do
          sign_in user
          get :request_friend, :id => another_user.id
        end

        it "sets a success flash" do
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to another user's profile" do
          expect(response).to redirect_to(user_profile_path(another_user))
        end
      end

      context "user not logged in" do
        before do
          get :request_friend, :id => another_user.id
        end
        it "requires user to log in" do
          expect(response).to redirect_to(user_session_path)
        end

        it "sets an error flash" do
          expect(flash[:alert]).to_not be_nil
        end
      end
    end

    context "accept friending request" do
      context "user logged in" do
        before do
          sign_in user
          subject.class.request_friend(another_user, user)

          get :accept_friend, :id => another_user.id
        end

        it "sets a success flash" do
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to another user's profile" do
          expect(response).to redirect_to(user_profile_path(another_user))
        end
      end

      context "user not logged in" do
        before do
          subject.class.request_friend(another_user, user)

          get :accept_friend, :id => another_user.id
        end
        it "requires user to log in" do
          expect(response).to redirect_to(user_session_path)
        end

        it "sets an error flash" do
          expect(flash[:alert]).to_not be_nil
        end
      end
    end

    context "delete friend" do
      context "user logged in" do
        before do
          sign_in user
          subject.class.request_friend(another_user, user)
          subject.class.accept_friend(another_user, user)

          get :delete_friend, :id => another_user.id
        end

        it "sets a success flash" do
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to another user's profile" do
          expect(response).to redirect_to(user_profile_path(another_user))
        end
      end

      context "user not logged in" do
        before do
          subject.class.request_friend(another_user, user)
          subject.class.accept_friend(another_user, user)
          get :delete_friend, :id => another_user.id
        end
        it "requires user to log in" do
          expect(response).to redirect_to(user_session_path)
        end

        it "sets an error flash" do
          expect(flash[:alert]).to_not be_nil
        end
      end
    end

    context "reject friending request" do
      context "user logged in" do
        before do
          sign_in user
          subject.class.request_friend(another_user, user)

          get :reject_friend, :id => another_user.id
        end

        it "sets a success flash" do
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to another user's profile" do
          expect(response).to redirect_to(user_profile_path(user))
        end
      end

      context "user not logged in" do
        before do
          subject.class.request_friend(another_user, user)

          get :reject_friend, :id => another_user.id
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

end
