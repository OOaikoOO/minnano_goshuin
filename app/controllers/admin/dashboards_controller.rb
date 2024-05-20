class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    # ユーザー一覧表示
    @users = User.all
  end
  
end
