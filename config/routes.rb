Rails.application.routes.draw do
  root to: 'application#live'

  resources :invoices, only: [:show] do
    post '/(:id)', action: :store, on: :collection, as: :store
  end
  resources :tokens, only: [:index]
end
