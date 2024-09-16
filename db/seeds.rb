# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

=begin
require 'faker'

Post.delete_all
Comment.delete_all
User.delete_all

10.times do
  name = Faker::Name.first_name
  email = "#{name}@provider.com"
  User.create!(
    name: name,
    email: email,
    password: Devise.friendly_token[0,20]
  )
end

User.all.each do |user|
  user.posts.create!(body: 'Lorem Ipsum...')
end

User.all.each do |user|
  Post.all.each do |post|
    user.comments.create!(post_id: post.id, content: 'One of us')
  end
end
=end
