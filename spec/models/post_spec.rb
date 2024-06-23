# frozen_string_literal: true

require 'rails_helper'

describe Post, type: :model do
  context "寺社名と紹介文が入力されている場合" do
    let!(:post) { create(:post) }
    it "有効な投稿内容の場合は保存されるか" do
      expect(post).to be_valid
    end
  end
  
  context "バリデーションの確認" do
    it "寺社名が空の場合は無効であること" do
      post = build(:post, title: "")
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("を入力してください")
    end
    
    it "紹介文が空の場合は無効であること" do
      post = build(:post, introduction: "")
      expect(post).not_to be_valid
      expect(post.errors[:introduction]).to include("を入力してください")
    end
    
    it "寺社名が50文字を超える場合は無効であること" do
      post = build(:post, title: Faker::Lorem.characters(number: 51))
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("は50文字以内で入力してください")
    end
    
    it "紹介文が250文字を超える場合は無効であること" do
      post = build(:post, introduction: Faker::Lorem.characters(number: 251))
      expect(post).not_to be_valid
      expect(post.errors[:introduction]).to include("は250文字以内で入力してください")
    end
  end
end