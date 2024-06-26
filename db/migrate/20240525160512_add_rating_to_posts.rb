# frozen_string_literal: true

class AddRatingToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rating, :float
  end
end
