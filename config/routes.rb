Rails.application.routes.draw do
  # ユーザー用
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  # ユーザー退会関連
  get '/users/check' => 'public/users#check', as: :check_user
  patch '/users/withdraw' => 'public/users#withdraw', as: :withdraw_user

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # resourcesを使用する際にURLにnamespaceを含めずにルーティングを設定する
  scope module: :public do
    resources :posts
    resources :users
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
