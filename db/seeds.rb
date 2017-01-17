# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all

authors = ["Jack", "Emily", "Daniel", "John", "Gabe", "Sarah"]

10.times do |post|
  Post.new(:body => Faker::Lorem.sentence, :author_name => authors.sample)

  Post.save!
end
