class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
    
    # タグでフィルタリング
    if params[:tag].present?
      @posts = @posts.tagged_with(params[:tag])
    end
    
    # ご朱印の有無でフィルタリング
    if params[:receive_shuin].present?
      @posts = @posts.where(receive_shuin: params[:receive_shuin] == 'true')
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
    @star_rating = @post.star.to_f
    @average_rating = @post.average_comment_rating
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        redirect_to post_path(@post), notice: "投稿が更新されました"
      else
        render :edit
      end
    else
      redirect_to posts_path, notice: "他のユーザーの投稿を編集することはできません"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to user_path(current_user.id), notice: '投稿が削除されました'
    else
      redirect_to posts_path, notice: "他のユーザーの投稿を削除することはできません"
    end
  end
  
  # タグで投稿を絞り込む
  def tagged
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).page(params[:page])
    else
      @posts = Post.all
    end
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :tag_list, :image, :star, :introduction, :receive_shuin)
  end
end
