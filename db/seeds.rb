# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Task.delete_all
User.destroy_all

3.times do
  User.create!(
    full_name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: 'password',
    role: User.roles.keys.sample
  )
end

User.find_each do |user|
  rand(2..5).times do
    Task.create!(
      description: Faker::Lorem.paragraph,
      status: Task.statuses.keys.sample,
      date: DateTime.now,
      user: user
    )
  end
end
