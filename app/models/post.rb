class Post < ApplicationRecord

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

  belongs_to :user
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :address, presence: true
end
