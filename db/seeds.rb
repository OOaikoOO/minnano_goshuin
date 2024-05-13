# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rick = User.find_or_create_by!(email: "rick@example.com") do |user|
  user.name = "Rick"
  user.password = "password"
end

Carl = User.find_or_create_by!(email: "Carl@example.com") do |user|
  user.name = "Carl"
  user.password = "password"
end

Daryl = User.find_or_create_by!(email: "Daryl@example.com") do |user|
  user.name = "Daryl"
  user.password = "password"
end

Carol = User.find_or_create_by!(email: "Carol@example.com") do |user|
  user.name = "Carol"
  user.password = "password"
end

Maggie = User.find_or_create_by!(email: "maggie@example.com") do |user|
  user.name = "Maggie"
  user.password = "password"
end

Michonne = User.find_or_create_by!(email: "michonne@example.com") do |user|
  user.name = "Michonne"
  user.password = "password"
end