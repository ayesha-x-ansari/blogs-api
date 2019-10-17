Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  scope module: 'api' do
    scope module: 'v1' do
      resources :blogs do
        resources :comments
      end
    end
  end
  resources :sessions, only: [:create, :destroy]
  post 'signup', to: 'users#create'

  resources :blogs
  resources :comments
end