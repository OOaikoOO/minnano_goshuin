class Post < ApplicationRecord
  def self.looks(search, word)
    case search
    when "partial"
      # 異なる2つのカラムに対して同じ検索パターンを適用するため"%#{word}%"などを2回繰り返し記述する
      # 検索条件が複数あるためORメソッドを使用する
      where("title LIKE ? OR address LIKE ?", "%#{word}%", "%#{word}%")
    when "prefix"
      where("title LIKE ? OR address LIKE ?", "#{word}%", "#{word}%")
    when "suffix"
      where("title LIKE ? OR address LIKE ?", "%#{word}", "%#{word}")
    when "exact"
      where("title = ? OR address = ?", word, word)
    else
      none # 条件に合致する投稿が無い場合に空のクエリを返す
    end
  end
  
  belongs_to :user
  
  validates :title, presence: true
  validates :address, presence: true
end
