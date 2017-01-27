# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying all posts"
Post.destroy_all

puts "destroying all comments"
Comment.destroy_all

puts "destroying all likes"
Like.destroy_all


authors = {1 => "Jack",
           2 => "Emily",
           3 => "Daniel",
           4 => "John",
           5 => "Gabe",
           6 => "Sarah",
           7 => "Judy",
           8 => "Alexandra",
           9 => "Maria"}

10.times do
  puts "creating a post"
  Post.create!(:body => Faker::Lorem.paragraphs(3),
           :user_id => authors.keys.sample)


  post = Post.last

  puts "creating random comments"
  rand(0..6).times do
    Comment.create!(:body => Faker::Lorem.sentence,
                :user_id => authors.keys.sample,
                :commentable_type => "Post",
                :commentable_id => post.id)


    puts "creating random likes for the comment"
    rand(0..6).times do
      Like.create!(:user_id => authors.keys.sample,
                   :likeable_type => "Comment",
                   :likeable_id => Comment.last.id)
    end
  end

  puts "creating random likes for the post"
  rand(0..6).times do
    Like.create!(:user_id => authors.keys.sample,
                 :likeable_type => "Post",
                 :likeable_id => post.id)
  end
end
