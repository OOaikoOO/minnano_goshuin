class Post < ApplicationRecord

  belongs_to :user
  has_many :wish_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  # タグ付け機能
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :introduction, presence: true, length: { maximum: 250 }
  validates :receive_shuin, inclusion: { in: [true, false] }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 最新の投稿を先頭にする
  scope :recent, -> { order(created_at: :desc) }

  def self.search_for(content, method, field = 'title')
    # 神社仏閣の名前で検索
    if field == 'title'
      if method == 'perfect'
        Post.where(title: content)
      elsif method == 'forward'
        Post.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        Post.where('title LIKE ?', '%'+content)
      else
        Post.where('title LIKE ?', '%'+content+'%')
      end
    # 所在地で検索
    elsif field == 'address'
      if method == 'perfect'
        Post.where(address: content)
      elsif method == 'forward'
        Post.where('address LIKE ?', content+'%')
      elsif method == 'backward'
        Post.where('address LIKE ?', '%'+content)
      else
        Post.where('address LIKE ?', '%'+content+'%')
      end
    else
      Post.none # 入力が無効な場合、空の結果を返す
    end
  end

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
