require 'rails_helper'

describe CommentsController do
    let(:user) { create(:user)}
    let(:text_post) { user.text_posts.create(:body => "this is a text post")}
    let(:pic_post) { user.pic_posts.create(file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/photos/elliot.jpg", "image/jpg"))}
    
    describe "POST #create", focus: true do
        let(:comment_create_valid) do
            post :create, params: {
                "comment": {
                    "body": "my new comment",
                    "commentable": "Post",
                    "commentable_id": text_post.id
                },
                "commentable": "Post",
                "commentable_id": text_post.id
            }
        end

        let(:comment_create_invalid) do
            post :create, :post_id => text_post.id,
            comment: {:body => nil}
        end

        let(:comment_on_pic) do
            post :create, :user_id => user.id, :picture_id => pic_post.id,
            comment: {:body => "my new comment"}
        end

        context "user is logged in" do
            before do
                sign_in user
                text_post
            end

            context "attributes are valid" do
                it "creates comment successfully" do
                    expect {comment_create_valid}.to change(Comment, :count).by(1)
                end
            end
        end

    end

end