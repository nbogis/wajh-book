require 'rails_helper'

describe PostsController do

  let(:user) { create(:user)}
  let(:text_post) { user.text_posts.create(:body => "this is a text post")}

  describe "GET #index" do
    before do
      sign_in user
    end

    it "shows an array of posts" do
      text_post
      another_text_post = user.text_posts.create(:body => "this is another text post")
      get :index
      expect(assigns(:posts)).to match_array([text_post, another_text_post])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    let(:post_create_valid) do
      post :create,
      post: {:body => "this is a text post" }
    end
    let(:post_create_invalid) do
      post :create,
      post: { body: nil }
    end

    context "user is logged in" do
      before do
        sign_in user
      end

      context "attributes are valid" do
        it "create post successfully" do
          expect { post_create_valid }.to change(Post, :count).by(1)
        end

        it "sets a success flash message" do
          post_create_valid
          expect(flash[:success]).to_not be_nil
        end

        it "redirects to post index" do
          post_create_valid
          expect(response).to redirect_to(:root)
        end
      end

      context "attributes are invalid" do
        it "fails to create post" do
          expect { post_create_invalid }.to change(Post, :count).by(0)
        end

        it "sets error flash message" do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end

        it "renders the new template" do
          post_create_invalid
          expect(response).to render_template(:new)
        end
      end
    end

    context "user not logged in" do
      before do
        post_create_valid
      end

      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an alert flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe "GET #show" do
    context "user is logged in" do
      before do
        sign_in user
        text_post
      end
      it "successfully shows the post" do
        get :show, :id => text_post.id
        expect(response).to be_success
      end
    end

    context "user not logged in" do
      before do
        text_post
        get :show, :id => text_post.id
      end

      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an alert flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in user
      text_post
    end
    context "user is logged in" do
      it "successfully works when user is logged in" do
        get :edit, :id => text_post
        expect(response).to be_success
      end
    end
    context "user not logged in" do
      before do
        sign_out user
        get :edit, :id => text_post
      end
      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an alert flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end


  end

  describe "PATCH #update", focus: true do
    let(:post_update_valid) do
      put :update, :id => text_post.id, post: {:body => "updated post"}
    end

    let(:post_update_invalid) do
      put :update, :id => text_post.id,
      post: {:body => nil}
    end

    context "user is logged in" do
      before do
        sign_in user
      end

      context "attributes are valid" do
        before do
          post_update_valid
          text_post.reload
        end
        it "redirect to the text post" do
          expect(response).to redirect_to(text_post)
        end

        it "sets success flash message" do
          expect(flash[:success]).to_not be_nil
        end

      end

      context "attributes are invalid" do
        before do
          post_update_invalid
          text_post.reload
        end
        it "renders edit remplate" do
          expect(response).to render_template(:edit)
        end

        it "sets error flash message" do
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context "user not logged in" do
      before do
        post_update_valid
      end

      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an alert flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    context "user is logged in" do
      before do
        sign_in user
        text_post
      end

      it "destroys the protocol" do
        expect {delete :destroy, :id => text_post.id}.to change(Post, :count).by(-1)
      end

      it "redirects back to the root" do
        delete :destroy, :id => text_post.id
        expect(response).to redirect_to :root
      end

      it "sets success flash message" do
        delete :destroy, :id => text_post.id
        expect(flash[:success]).to_not be_nil
      end
    end

    context "user not logged in" do
      before do
        text_post
        delete :destroy, :id => text_post.id
      end

      it "requires user to log in" do
        expect(response).to redirect_to(user_session_path)
      end

      it "sets an alert flash" do
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
