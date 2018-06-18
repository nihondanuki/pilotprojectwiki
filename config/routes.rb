Rails.application.routes.draw do
  resources :users
  get 'sessions/new'

end
