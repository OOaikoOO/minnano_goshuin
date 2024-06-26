# frozen_string_literal: true

class Public::WishListsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    WishList.create(user_id: current_user.id, post_id: @post.id)
  end

  def destroy
    WishList.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
