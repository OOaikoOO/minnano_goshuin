# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WishList, type: :model do
  context "バリデーションの確認" do
    # post1とpost2を事前に作成する
    let!(:user) { create(:user) }
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }

    it "同じユーザーが同じ投稿を重複してWishListに追加できないこと" do
      create(:wish_list, user: user, post: post1)

      # 同じユーザーが同じ投稿をWishListに追加しようとすると無効であることをテスト
      duplicate_wish_list = build(:wish_list, user: user, post: post1)
      expect(duplicate_wish_list).not_to be_valid
      expect(duplicate_wish_list.errors[:user_id]).to include("はすでに存在します")
    end

    it "異なるユーザーが同じ投稿をWishListに追加できること" do
      create(:wish_list, user: user, post: post1)

      # 別のユーザーが同じ投稿をWishListに追加できることを確認
      another_user = create(:user)
      another_wish_list = build(:wish_list, user: another_user, post: post1)
      expect(another_wish_list).to be_valid
    end

    it "同じユーザーが異なる投稿をWishListに追加できること" do
      create(:wish_list, user: user, post: post1)

      # 同じユーザーが異なる投稿をWishListに追加できることを確認
      different_post_wish_list = build(:wish_list, user: user, post: post2)
      expect(different_post_wish_list).to be_valid
    end
  end
end