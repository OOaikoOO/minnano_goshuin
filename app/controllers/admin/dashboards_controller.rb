class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # ユーザーの総投稿数と総コメント数をカウント
    @users = User.left_joins(:posts, :comments)
                 .select('users.*, COUNT(DISTINCT posts.id) AS posts_count, COUNT(DISTINCT comments.id) AS comments_count')
                 .group('users.id')

    # 会員ステータスによる絞り込み
    @users = @users.where(is_deleted: params[:status] == '退会済み') if params[:status].present?

    # ユーザーのソート機能
    case params[:sort]
    when 'created_at_desc'
      @users = @users.order(created_at: :desc)
    when 'created_at_asc'
      @users = @users.order(created_at: :asc)
    when 'posts_count_desc'
      @users = @users.order('posts_count DESC')
    when 'posts_count_asc'
      @users = @users.order('posts_count ASC')
    when 'comments_count_desc'
      @users = @users.order('comments_count DESC')
    when 'comments_count_asc'
      @users = @users.order('comments_count ASC')
    end

    @sort = params[:sort] # 現在のソート順をビューに渡す
  end
end
