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

  authenticated :user do
    root 'families/reading_logs#index', as: :authenticated_user_root
  end

  scope module: :users do
    resource :profile, only: %i[show]
  end

  resource :family, only: %i[new edit create update] do
    resources :reading_logs, only: %i[index], module: :families
    resource :library, only: %i[show], module: :families do
      resources :books, only: %i[show destroy], module: :libraries do
        resources :reading_logs, only: %i[show new edit create update destroy], module: :books do
          resources :comments, only: %i[create update destroy], module: :reading_logs
        end
      end
    end
  end
  resources :books, only: %i[show create] do
    collection do
      get :search
    end
  end

  root 'static_pages#home'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
