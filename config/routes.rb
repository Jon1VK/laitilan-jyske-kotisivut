Rails.application.routes.draw do
  root 'static#index'
  
  devise_for :athletes, path: 'edustusurheilijat', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }

  resources :athletes, path: 'edustusurheilijat', only: [:index, :show, :edit, :update]
end
