class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]
    
    case @range # 条件分岐が複数あるためcase文を使用
    when "ユーザー名"
      search_users
    when "神社仏閣の名前"
      search_posts
    when "所在地"
      search_addresses
    end
  end
  
  private
  
  def search_users
    @users = User.looks(@search, @word)
  end
  
  def search_posts
    @posts = Post.looks(@search, @word)
  end
  
  def search_addresses
    @posts = Post.where(address: @word)
  end
end
