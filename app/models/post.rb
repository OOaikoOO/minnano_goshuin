# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :wish_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :introduction, presence: true, length: { maximum: 250 }
  validates :receive_shuin, inclusion: { in: [true, false] }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 最新の投稿を先頭にする
  scope :recent, -> { order(created_at: :desc) }

  def self.search_for(content, method, field = "title")
    # 神社仏閣の名前で検索
    if field == "title"
      if method == "perfect"
        Post.where(title: content)
      elsif method == "forward"
        Post.where("title LIKE ?", content + "%")
      elsif method == "backward"
        Post.where("title LIKE ?", "%" + content)
      else
        Post.where("title LIKE ?", "%" + content + "%")
      end
    # 所在地で検索
    elsif field == "address"
      if method == "perfect"
        Post.where(address: content)
      elsif method == "forward"
        Post.where("address LIKE ?", content + "%")
      elsif method == "backward"
        Post.where("address LIKE ?", "%" + content)
      else
        Post.where("address LIKE ?", "%" + content + "%")
      end
    else
      Post.none # 入力が無効な場合、空の結果を返す
    end
  end

  # 投稿のソート機能
  def self.sorted_posts(sort_by)
    case sort_by
    when "created_at_asc"
      order(created_at: :asc)
    when "comments_count_asc"
      left_joins(:comments).group(:id).order("COUNT(comments.id) ASC")
    when "comments_count_desc"
      left_joins(:comments).group(:id).order("COUNT(comments.id) DESC")
    else
      order(created_at: :desc)
    end
  end

  # タグで投稿を絞り込む
  def self.tagged_posts(tag_name, page)
    if tag_name.present?
      tagged_with(tag_name).page(page)
    else
      all
    end
  end

  # ご朱印の有無でフィルタリング
  def self.filter_by_receive_shuin(receive_shuin)
    if receive_shuin.present?
      where(receive_shuin: receive_shuin)
    else
      all
    end
  end

  scope :wish_listed_by_user, ->(user) {
    joins(:wish_lists).where(wish_lists: { user_id: user.id })
  }

  def wish_listed_by?(user)
    wish_lists.exists?(user_id: user.id)
  end

  def image_url
    image.present? ? image.url : nil
  end

  def average_comment_rating
    comments.average(:star).to_f.round(2)
  end
end
