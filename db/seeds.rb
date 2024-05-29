# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin データを作成
Admin.create!(
  email: "admin@admin",
  password: "adminadmin"
)

# User データを作成
users = [
  { name: "Rick", email: "rick@example.com", password: "password" },
  { name: "Carl", email: "carl@example.com", password: "password" },
  { name: "Daryl", email: "daryl@example.com", password: "password" },
  { name: "Carol", email: "carol@example.com", password: "password" },
  { name: "Maggie", email: "maggie@example.com", password: "password" },
  { name: "Michonne", email: "michonne@example.com", password: "password" }
]

# users 配列をループして User データを作成
users.each do |user_data|
  User.create!(user_data)
end

# Rick ユーザーに関連付けられた投稿データを作成
# rick_user = User.find_by(name: "Rick")
# 10.times do |n|
  # post = Post.create!(
    # title: "ジンジャー神社",
    # address: "京都府京都市",
    # user_id: rick_user.id
  # )

  # Rick以外のユーザーがRickの投稿に1回ずつコメントする
  # users.reject { |user| user == rick_user }.each do |other_user_data|
    # other_user = User.find_by(name: other_user_data[:name]) # 正しいユーザーオブジェクトを取得
    # post.comments.create!(
      # comment: "いいね！",
      # user_id: other_user.id
    # )
  # end
# end