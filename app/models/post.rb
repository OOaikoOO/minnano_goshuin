class Post < ApplicationRecord
  def self.looks(search, word)
    case search
    when "partial"
      where("title LIKE ?", "%#{word}%")
    when "prefix"
      where("title LIKE ?", "#{word}%")
    when "suffix"
      where("title LIKE ?", "%#{word}")
    when "exact"
      where(title: word)
    else
      none # 条件に合致する投稿が無い場合に空のクエリを返す
    end
  end
  
  belongs_to :user
  
  validates :title, presence: true
  validates :address, presence: true
end
