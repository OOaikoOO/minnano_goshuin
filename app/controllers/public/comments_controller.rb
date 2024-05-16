class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to @post, notice: "コメントを投稿しました"
    else
      redirect_to @post, notice: "コメントの投稿に失敗しました"
    end
    byebug
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to @post, notice: "コメントを削除しました"
    else
      redirect_to @post, notice: "コメントの削除に失敗しました"
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
