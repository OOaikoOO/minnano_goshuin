class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.page(params[:page]).per(6)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_user_comments_path(@comment.user_id), notice: "コメントを削除しました"
  end
end
