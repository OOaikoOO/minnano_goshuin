Rails.application.routes.draw do
  # 管理者用
  namespace :admin do
    get 'comments/index'
    get 'posts/index'
    get "search" => "searches#search"
    root 'dashboards#index'
    get 'dashboard', to: 'dashboards#index', as: :dashboard
  end

  # ゲスト
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # ユーザー用
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  # ユーザー退会関連
  get '/users/check' => 'public/users#check', as: :check_user
  patch '/users/withdraw' => 'public/users#withdraw', as: :withdraw_user

  # 管理者用ログイン関連
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー用ログイン関連
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 「行きたいリスト」用
  resources :posts, controller: 'public/posts' do
    resources :wish_lists, only: [:create, :destroy], controller: 'public/wish_lists'
  end

  # resourcesを使用する際、URLにnamespaceを含めずにルーティングを設定する
  scope module: :public do
    get "search" => "searches#search"
    resources :posts do
      resources :comments, only: [:create, :destroy]
      collection do
        get 'tagged/:tag', to: 'posts#tagged', as: :tagged
      end
    end
    resources :users
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
