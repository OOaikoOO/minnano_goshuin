# frozen_string_literal: true

require "rails_helper"

describe Comment, type: :model do
  context "コメントが入力されている場合" do
    let!(:comment) { create(:comment) }
    it "有効なコメントの場合は保存されるか" do
      expect(comment).to be_valid
    end
  end

  context "関連付けの確認" do
    it "正しい投稿に関連付けられていること" do
      post = create(:post)
      comment = create(:comment, post: post)
      expect(comment.post).to eq post
    end
  end

  context "バリデーションの確認" do
    it "コメントが空の場合は無効であること" do
      comment = build(:comment, comment: "")
      expect(comment).not_to be_valid
      expect(comment.errors[:comment]).to include("を入力してください")
    end

    it "コメントが250文字を超える場合は無効であること" do
      comment = build(:comment, comment: Faker::Lorem.characters(number: 251))
      expect(comment).not_to be_valid
      expect(comment.errors[:comment]).to include("は250文字以内で入力してください")
    end
  end
end
