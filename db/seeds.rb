# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroy all users"
User.destroy_all

puts "destroying all friendings"
Friending.destroy_all

puts "destroying all posts"
Post.destroy_all

puts "destroying all postings"
Posting.destroy_all

puts "create users"
10.times do |i|
  password = Faker::Internet.password(5, 15)
  user = User.create!(:id => i,
               :email => Faker::Internet.email,
               :username => Faker::Internet.user_name,
               :password => password,
               :password_confirmation => password)

  user.profile.update_attributes( :home_place => Faker::Address.country,
                                  :current_place => Faker::Address.country,
                                  :college => Faker::University.name,
                                  :high_school => Faker::Educator.secondary_school,
                                  :about_me => Faker::Lorem.sentence,
                                  :interests => "sports",
                                  :relationship => "Signle",
                                  :work => Faker::Company.name,
                                  :languages => "Arabic, English",
                                  :phone => Faker::PhoneNumber.cell_phone,
                                  :dob => "2/4/1990".to_date)
  user.save!
end

10.times do
  puts "creating a post"
  user = User.find(rand(0..9))

  post = Post.create!(:body => Faker::Lorem.paragraph(3))

  user.postings.create!(:postable_type => "Post",
                        :postable_id => post.id)

  puts "creating random comments"
  rand(0..6).times do
    user = User.find(rand(0..9))
    comment = post.comments.create!(:body => Faker::Lorem.sentence,
                          :user_id => user.id)


    # puts "creating random likes for the comment"
    # rand(0..6).times do
    #   comment.likes.create!(:user_id => rand(0..10))
    # end
  end

  puts "creating random likes for the post"
  rand(0..6).times do
    user = User.find(rand(0..9))
    post.likes.create!(:user_id => user.id)
  end
end
