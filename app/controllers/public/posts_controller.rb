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
    @posts = Post.all
    # タグでフィルタリング
    if params[:tag].present?
      @posts = @posts.tagged_with(params[:tag])
    end
    
    # 投稿のソート機能
    @sort = params[:sort] || 'created_at_desc'
    case @sort
    when 'created_at_asc'
      @posts = @posts.order(created_at: :asc)
    when 'created_at_desc'
      @posts = @posts.order(created_at: :desc)
    when 'comments_count_asc'
      @posts = @posts.left_joins(:comments).group(:id).order('COUNT(comments.id) ASC')
    when 'comments_count_desc'
      @posts = @posts.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
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

  private

  def post_params
    params.require(:post).permit(:title, :address, :tag_list, :image, :star)
  end
end
