class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      redirect_to posts_path, notice: "他のユーザーの投稿を編集することはできません"
    end
  end

  # タグで投稿を絞り込む
  def tagged
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :tag_list)
  end
end
