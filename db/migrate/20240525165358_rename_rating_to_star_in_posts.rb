# frozen_string_literal: true

class RenameRatingToStarInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :rating, :star
  end
end
