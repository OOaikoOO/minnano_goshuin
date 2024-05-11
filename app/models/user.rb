class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # アカウントが削除されていないかを確認し、削除されていなければログインを許可
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  has_many :post, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
