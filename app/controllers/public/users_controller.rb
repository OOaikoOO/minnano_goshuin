class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def check
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueにすることでユーザーステータスが非アクティブ化する
    @user.update(is_deleted: true)
    # 退会処理後にログアウトさせる
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
