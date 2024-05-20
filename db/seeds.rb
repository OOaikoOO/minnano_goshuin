# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@admin",
  password: "adminadmin",
  )

User.create!(
  name: "Rick",
  email: "rick@example.com",
  password: "password",
  )

User.create!(
  name: "Carl",
  email: "carl@example.com",
  password: "password",
  )

User.create!(
  name: "Daryl",
  email: "daryl@example.com",
  password: "password",
  )

User.create!(
  name: "Carol",
  email: "carol@example.com",
  password: "password",
  )

User.create!(
  name: "Maggie",
  email: "maggie@example.com",
  password: "password",
  )

User.create!(
  name: "Michonne",
  email: "michonne@example.com",
  password: "password",
  )