# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  # アカウントが削除されていないかを確認し、削除されていなければログインを許可する
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # 名前でのユーザー検索
  def self.search_for(content, method)
    if method == "perfect"
      User.where(name: content)
    elsif method == "forward"
      User.where("name LIKE ?", content + "%")
    elsif method == "backward"
      User.where("name LIKE ?", "%" + content)
    else
      User.where("name LIKE ?", "%" + content + "%")
    end
  end

  # 投稿数をソート
  def post_count
    self.posts.count
  end

  # ゲストユーザー
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
