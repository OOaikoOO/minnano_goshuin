class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # アカウントが削除されていないかを確認し、削除されていなければログインを許可する
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def self.looks(search, word)
    case search
    when "partial"
      where("name LIKE ?", "%#{word}%")
    when "prefix"
      where("name LIKE ?", "#{word}%")
    when "suffix"
      where("name LIKE ?", "%#{word}")
    when "exact"
      where(name: word)
    else
      none # 条件に合致するユーザーがない場合に空のクエリを返す
    end
  end
  
  has_many :post, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
