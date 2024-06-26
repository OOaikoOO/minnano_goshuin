# frozen_string_literal: true

class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all

    # 会員ステータスによる絞り込み
    @users = @users.where(is_deleted: params[:status] == "退会済み") if params[:status].present?

    # ユーザーのソート機能
    case params[:sort]
    when "created_at_desc"
      @users = @users.order(created_at: :desc)
    when "created_at_asc"
      @users = @users.order(created_at: :asc)
    when "posts_count_desc"
      @users = @users.sort_by { |user| -user.posts.count }
    when "posts_count_asc"
      @users = @users.sort_by { |user| user.posts.count }
    when "comments_count_desc"
      @users = @users.joins(:comments).group("users.id").order("COUNT(comments.id) DESC")
    when "comments_count_asc"
      @users = @users.joins(:comments).group("users.id").order("COUNT(comments.id) ASC")
    end

    @users = Kaminari.paginate_array(@users).page(params[:page]).per(9) # ページネーションを適用する

    @sort = params[:sort] # 現在のソート順をビューに渡す
  end
end
