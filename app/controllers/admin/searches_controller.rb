class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'comment'
      @records = Comment.search_for(@content, @method)
    else
      @records = Post.search_for(@content, @method)
    end
  end
end
