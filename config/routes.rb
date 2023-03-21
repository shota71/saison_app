Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
  }
      resources :posts do
        post "favorites" => "posts#like"
        delete "favorites" => "posts#unlike"
      end
      get "users/auth" => 'users#auth'
      resources :users
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
