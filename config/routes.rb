Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :health, only: [:index]

  resources :users
  resources :organizations, param: :slug, except: [:update, :edit, :destroy] do
    post :create_members
    post :destroy
    get :add_members
    get :delete
    delete :leave
  end
  get '/organizations/:slug/accept_invitation/:confirmation_token', to: 'organizations#accept_invitation', as: 'organization_accept_invitation'
  put '/organizations/:slug/grant_admin/:user_uuid',    to: 'organizations#grant_admin',    as: 'organization_grant_admin'
  put '/organizations/:slug/revoke_admin/:user_uuid',   to: 'organizations#revoke_admin',   as: 'organization_revoke_admin'
  delete '/organizations/:slug/remove_member/:user_uuid',  to: 'organizations#remove_member',  as: 'organization_remove_member'

  resources :projects, param: :key do
    get :delete
    resources :boards, param: :slug, only: [:show]
    post :destroy
  end

  get '/user/:username', to: 'user_profiles#show', as: 'user_profile'

  root 'projects#index'

  namespace :admin do
    resources :users, param: :uuid
  end

  namespace :api, path: 'api/v:api_version', defaults: { format: :json } do
    namespace :internal do
      resources :columns, param: :uuid
      resources :cards, param: :uuid do
        post :create_board
      end

      resources :boards, param: :slug do
        put :reorder_columns
        put :reorder_cards
      end

      resources :card_items, param: :uuid

      resource :user_avatars, only: [:create, :destroy]
    end
  end
end
