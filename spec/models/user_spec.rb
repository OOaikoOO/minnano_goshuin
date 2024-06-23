# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context "バリデーションの確認" do
    it "正しい属性が与えられていれば有効であること" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    it "メールアドレスがなければ無効であること" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end
    
    it "重複したメールアドレスは無効であること" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end
    
    it "パスワードがなければ無効であること" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("を入力してください")
    end
    
    it "パスワードが6文字未満であれば無効であること" do
      user = build(:user, password: "12345")
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
  
  context "関連の確認" do
    it "投稿が複数紐づいていること" do
      user = create(:user)
      post1 = create(:post, user: user)
      post2 = create(:post, user: user)
      expect(user.posts.count).to eq 2
    end
    
    it "コメントが複数紐づいていること" do
      user = create(:user)
      post = create(:post)
      comment1 = create(:comment, user: user, post: post)
      comment2 = create(:comment, user: user, post: post)
      expect(user.comments.count).to eq 2
    end
    
    it "複数のWishListを持つこと" do
      user = create(:user)
      wish_list1 = create(:wish_list, user: user)
      wish_list2 = create(:wish_list, user: user)

      expect(user.wish_lists.count).to eq 2
      expect(user.wish_lists).to include(wish_list1)
      expect(user.wish_lists).to include(wish_list2)
    end
  end
end