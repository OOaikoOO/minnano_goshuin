Rails.application.routes.draw do
  namespace :public do
    get 'searches/search'
  end
  namespace :admin do
    get 'searches/search'
  end
  # ユーザー用
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  # ユーザー退会関連
  get '/users/check' => 'public/users#check', as: :check_user
  patch '/users/withdraw' => 'public/users#withdraw', as: :withdraw_user

  # ユーザー用ログイン関連
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # resourcesを使用する際にURLにnamespaceを含めずにルーティングを設定する
  scope module: :public do
    get "search" => "searches#search"
    resources :posts
    resources :users
  end

  # 管理者用ログイン関連
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get "search" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
