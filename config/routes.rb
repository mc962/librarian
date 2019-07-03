Rails.application.routes.draw do
  root to: 'codelets#index'

  resources :codelets
end
