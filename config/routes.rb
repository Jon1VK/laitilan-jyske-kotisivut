Rails.application.routes.draw do
  # Root page of the app
  root 'static#index'
  
  # Static pages
  get 'uutiset', to: 'static#news', as: :news
  get 'palkitseminen', to: 'static#awards', as: :awards
  
  # Admin login routes
  devise_for :users, path: 'admin', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  }
  
  # Admin dashboard routes
  namespace :admin do
    resources :users
    resources :athletes, only: [:index, :show, :edit, :update]
    resources :records
    
    root to: "athletes#index"
  end
  
  # Athlete login routes
  devise_for :athletes, path: 'edustusurheilijat', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }
  
  # Event resource routes
  resources :events, path: 'tapahtumakalenteri', only: [:index, :show]
  
  # Athlete resources routes
  resources :athletes, path: 'edustusurheilijat', only: [:index, :show, :edit, :update]
  
  # Record resources routes
  resources :records, path: 'seuraennatykset', only: [:index, :create] do
    get :disciplines, on: :collection
    get ':league', to: 'records#league', on: :collection, as: :league
    get ':league/top-10', to: 'records#top_ten', on: :collection, as: :top_ten
  end
  
  # Open mail in browser if dev environment
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
