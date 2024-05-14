class Admin::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]
    
    case @range # 条件分岐が複数あるためcase文を使用
    when "ユーザー名"
      search_users
    when "神社仏閣の名前"
      search_posts
    when "コメント"
      search_comments
    end
  end
  
  private
  
  def search_users
    @users = User.looks(@search, @word)
  end
  
  def search_posts
    @posts = Post.looks(@search, @word)
  end
  
  def search_comments
    @comments = Comment.looks(@search, @word)
  end
end
