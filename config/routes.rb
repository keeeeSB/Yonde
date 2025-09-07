Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    root 'static_pages#dashboard'
  end

  root 'static_pages#home'
end
