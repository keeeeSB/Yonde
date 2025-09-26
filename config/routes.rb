Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    root 'static_pages#dashboard'
  end

  scope module: :users do
    resource :profile, only: %i[show]
    resource :family, only: %i[new edit create update]
  end

  resources :books, only: %i[show] do
    collection do
      get :search
    end
  end

  root 'static_pages#home'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
