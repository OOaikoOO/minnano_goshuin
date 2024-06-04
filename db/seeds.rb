# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin データを作成
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

# User データを作成
rick = User.create(name: 'Rick', email: 'rick@example.com', password: 'password')
carl = User.create(name: 'Carl', email: 'carl@example.com', password: 'password')
daryl = User.create(name: 'Daryl', email: 'daryl@example.com', password: 'password')
carol = User.create(name: 'Carol', email: 'carol@example.com', password: 'password')
maggie = User.create(name: 'Maggie', email: 'maggie@example.com', password: 'password')
michonne = User.create(name: 'Michonne', email: 'michonne@example.com', password: 'password')

# 投稿データを作成
Post.find_or_create_by!(title: "石山寺") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.introduction = "紫式部ゆかりのお寺"
  post.address = "滋賀県大津市石山寺1-1-1"
  post.receive_shuin = true
  post.user = rick
end

Post.find_or_create_by!(title: "三室戸寺") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.introduction = "紫陽花で有名なお寺"
  post.address = "京都府宇治市莵道滋賀谷21"
  post.receive_shuin = true
  post.user = carl
end

Post.find_or_create_by!(title: "油日神社") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.introduction = "映画の撮影で使われた神社"
  post.address = "滋賀県甲賀市甲賀町油日1042"
  post.receive_shuin = true
  post.user = daryl
end