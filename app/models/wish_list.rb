# frozen_string_literal: true

class WishList < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 同じユーザーが同じ投稿に複数回行えないようにする
  validates :user_id, uniqueness: { scope: :post_id }
end
