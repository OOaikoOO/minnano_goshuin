class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :address)
  end
end
