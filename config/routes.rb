Rails.application.routes.draw do
  root to: 'codelets#index'

  resources :codelets

  resources :basic_sessions, only: [:create]
end
