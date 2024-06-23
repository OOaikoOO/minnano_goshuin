# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  context "コメントが入力されている場合" do
    let!(:comment) { create(:comment) }
    it "有効なコメントの場合は保存されるか" do
      expect(comment).to be_valid
    end
  end
end