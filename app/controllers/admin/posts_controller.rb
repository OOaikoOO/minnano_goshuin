class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(9)
    
    # 各投稿の平均評価を計算
    @average_ratings = {}
    @posts.each do |post|
      if post.comments.any?
        average_rating = post.comments.average(:star).to_f.round(2)
        @average_ratings[post.id] = average_rating
      else
        @average_ratings[post.id] = 0
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_posts_path(@post.user), notice: "投稿を削除しました"
  end
end
