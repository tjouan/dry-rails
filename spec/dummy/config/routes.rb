Rails.application.routes.draw do
  resources :articles, except: :show
end
