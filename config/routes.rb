Rails.application.routes.draw do
  # Root page of the app
  root 'static#index'

  # Admin login routes
  devise_for :users, path: 'admin', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  }

  # Admin dashboard routes
  namespace :admin do
    resources :athletes, path: 'edustusurheilijat'
    resources :users, path: 'seurakäyttäjät'

    root to: "athletes#index"
  end
  
  # Athlete login routes
  devise_for :athletes, path: 'edustusurheilijat', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }

  # Athlete resource routes
  resources :athletes, path: 'edustusurheilijat', only: [:index, :show, :edit, :update]

  # Open mail in browser if dev environment
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
