class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'address'
      # postモデルで使用しているfieldパラメータのデフォルトは'title'のため明示的に'address'を指定する
      @records = Post.search_for(@content, @method, 'address')
    else
      @records = Post.search_for(@content, @method)
    end
  end
end
