class Public::PostCommentsController < ApplicationController
  
  def create
    post = Post.sind(params[:id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    somment.post = post.id
    comment.save
    redirect_to post_oath(post)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post.id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
