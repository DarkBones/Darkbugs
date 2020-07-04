Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  post 'uploads/user_avatar' => 'uploads#create_user_avatar'
  delete 'uploads/user_avatar' => 'uploads#delete_user_avatar'

  resources :users
  resources :organizations, only: [:create]

  root 'home#index'
end
