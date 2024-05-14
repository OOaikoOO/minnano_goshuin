class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]
    search_users if @range == "ユーザー"
    search_posts if @range == "投稿"
  end
  
  private
  
  def search_users
    @users = User.looks(@search, @word)
  end
  
  def search_posts
    @users = Post.looks(@search, @word)
  end
end
