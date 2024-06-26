# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    # ユーザー情報詳細
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    # !をつけて、true/falseを反転させて、有効、退会を切り替えることができる。
    @user.update(is_deleted: !@user.is_deleted)
    if @user.is_deleted
      flash[:notice] = "会員ステータスが無効になりました"
    else
      flash[:notice] = "会員ステータスが有効になりました"
    end
    redirect_to admin_user_path(@user)
  end
end
